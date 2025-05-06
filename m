Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5B1C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 22:12:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 556104025D;
	Wed,  7 May 2025 00:12:34 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 914524025A
 for <dev@dpdk.org>; Wed,  7 May 2025 00:12:32 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 4DC082115DD2; Tue,  6 May 2025 15:12:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4DC082115DD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746569551;
 bh=vMv/PZzX8iMrmVj+Ik3Y4DcUEz6gGLJ6s28o1Lp/4gc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oNi558v8aLLpCli3iKWdUD94AWYoEITOGnfdYsXParE5RTbqDUtPfl/Ha1cjv4rei
 LS0vosbUM/oK+htdtDvHFsVP04iPwmYtCyWjw0Z3t/7LLXFBle3VPFjxr5x1+wqmOI
 QMV0w8q+JYQ1kto9xh/GFIzovUDDH14CkNnrEdSg=
Date: Tue, 6 May 2025 15:12:31 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
Message-ID: <20250506221231.GA10462@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
 <1746474405-5056-2-git-send-email-andremue@linux.microsoft.com>
 <34050120-4370-4cbb-aeb2-c6956896cde6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34050120-4370-4cbb-aeb2-c6956896cde6@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Tue, May 06, 2025 at 01:47:03AM +0300, Dmitry Kozlyuk wrote:
> Hi Andre,
> 
> On 05.05.2025 22:46, Andre Muezerie wrote:
> >When compiling drivers on Windows, instances have been seen where a
> >temporary directory fails to get cleaned up due to
> >ERROR_SHARING_VIOLATION (32).
> >
> >Code inspection did not reveal problems with the DPDK code and scripts,
> >and this issue was only seen on Windows. Adding a 1 second sleep before
> >cleaning up the temporary directory seems to be effective, but to
> >guarantee that this break does not happen anymore, flag
> >"ignore_cleanup_errors" is set to "True".
> >
> >Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> >---
> >  buildtools/gen-pmdinfo-cfile.py | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> >diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
> >index 5fbd51658a..2ddbdb9502 100644
> >--- a/buildtools/gen-pmdinfo-cfile.py
> >+++ b/buildtools/gen-pmdinfo-cfile.py
> >@@ -6,9 +6,10 @@
> >  import subprocess
> >  import sys
> >  import tempfile
> >+import time
> >  _, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
> >-with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
> >+with tempfile.TemporaryDirectory(dir=tmp_root, ignore_cleanup_errors=True) as temp:
> >      paths = []
> >      for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
> >                                 check=True).stdout.decode().splitlines():
> >@@ -19,3 +20,10 @@
> >                             check=True, cwd=temp)
> >              paths.append(os.path.join(temp, name))
> >      subprocess.run(pmdinfogen + paths + [output], check=True)
> >+
> >+    if os.name == "nt":
> >+        # Instances have been seen on Windows where the temporary directory fails to get cleaned
> >+        # up due to ERROR_SHARING_VIOLATION (32).
> >+        # The sleep below is a mitigation for that issue, while ignore_cleanup_errors=True avoids
> >+        # failures when the issue is hit despite the mitigation.
> >+        time.sleep(1)
> 
> Not fond of this timing hack at all.
> Meson 0.51 (minimum requirement is 0.57) introduced |@PRIVATE_DIR@
> for custom_target() [1].
> Can we use it to get rid of tempfile.TemporaryDirectory?
> 
> drivers/meson.build:
>     custom_target(command: [pmdinfo, '@PRIVATE_DIR@', ...], ...)
> 
> buildtools/gen-pmdinfo-cfile.py:
>     _, temp, ..., *pmdinfogen = sys.argv
>     for name in subprocess.run([ar, "t", ...):
>        ...
>        subprocess.run([ar, "x", ...], cwd=temp)
>        ...
> |
> 
> |[1]: https://mesonbuild.com/Reference-manual_functions.html#custom_target
> |

Yes, I like your suggestion. I'll send out a V2 with the change you suggested.
Thanks for providing all the details about custom_target() and @PRIVATE_DIR@.
