Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B96C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 20:09:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 699814025D;
	Mon,  5 May 2025 22:09:50 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id AA58A4003C
 for <dev@dpdk.org>; Mon,  5 May 2025 22:09:49 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 8528721104A6; Mon,  5 May 2025 13:09:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8528721104A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746475788;
 bh=O2znoNjtCaw+sIb9EHr5n4IO84+gJ1mEBNDKxlC1pig=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lHVJIAvYY9UX/RqpdFSPoBUk0sGhB39+MdIxfKvyF49IItrhHPMgrHYmNwzJbNx/H
 r4knojaFB2YiuBrQYLfshjp9dyOkRJhnn0w6JaZMIJnBQ05Y+aGZTaQjSBPazIPU/0
 9fEtHRoBJn7uf6Gy2oeglHx4yRBdEFlEcBRG1Tgg=
Date: Mon, 5 May 2025 13:09:48 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
Message-ID: <20250505200948.GA6580@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
 <1746474405-5056-2-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746474405-5056-2-git-send-email-andremue@linux.microsoft.com>
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

On Mon, May 05, 2025 at 12:46:45PM -0700, Andre Muezerie wrote:
> When compiling drivers on Windows, instances have been seen where a
> temporary directory fails to get cleaned up due to
> ERROR_SHARING_VIOLATION (32).
> 
> Code inspection did not reveal problems with the DPDK code and scripts,
> and this issue was only seen on Windows. Adding a 1 second sleep before
> cleaning up the temporary directory seems to be effective, but to
> guarantee that this break does not happen anymore, flag
> "ignore_cleanup_errors" is set to "True".
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  buildtools/gen-pmdinfo-cfile.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
> index 5fbd51658a..2ddbdb9502 100644
> --- a/buildtools/gen-pmdinfo-cfile.py
> +++ b/buildtools/gen-pmdinfo-cfile.py
> @@ -6,9 +6,10 @@
>  import subprocess
>  import sys
>  import tempfile
> +import time
>  
>  _, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
> -with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
> +with tempfile.TemporaryDirectory(dir=tmp_root, ignore_cleanup_errors=True) as temp:

This built fine on my machine but failed on the CI.

According to doc\guides\linux_gsg\sys_reqs.rst, currently the minimum
required Python version is 3.6.
However, parameter ignore_cleanup_errors parameter was added in 3.10
(https://docs.python.org/3/library/tempfile.html)

Is there something that blocks us from requiring 3.10 at minimum? Is this
something that could be done for the next release?

>      paths = []
>      for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
>                                 check=True).stdout.decode().splitlines():
> @@ -19,3 +20,10 @@
>                             check=True, cwd=temp)
>              paths.append(os.path.join(temp, name))
>      subprocess.run(pmdinfogen + paths + [output], check=True)
> +
> +    if os.name == "nt":
> +        # Instances have been seen on Windows where the temporary directory fails to get cleaned
> +        # up due to ERROR_SHARING_VIOLATION (32).
> +        # The sleep below is a mitigation for that issue, while ignore_cleanup_errors=True avoids
> +        # failures when the issue is hit despite the mitigation.
> +        time.sleep(1)
> -- 
> 2.49.0.vfs.0.2
