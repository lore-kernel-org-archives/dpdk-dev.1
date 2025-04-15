Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6020C369B4
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 14:36:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B51FF40289;
	Tue, 15 Apr 2025 16:36:41 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 132B940263
 for <dev@dpdk.org>; Tue, 15 Apr 2025 16:36:40 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 10C6A210C443; Tue, 15 Apr 2025 07:36:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10C6A210C443
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744727799;
 bh=7Rb/6V0qg+rf3+z/z+Xk0vBQa+BAKo0F3l5TttL7TIQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bm3gu5k9D3mvgMVOiB0TcsNtoKv2OiPYuZjtVeUZ9qYRoAE5bwd/4WrDUMBCPrjfy
 +HlkoW3laaBlJgPfLh1cWhklaf4NKbvVCX0yit2/FpQKEiPNBgwp516JBdlT9yayVQ
 WoRdmBqRtEGgWKl3TG5SJbcmyjG6jUu4XK20m63g=
Date: Tue, 15 Apr 2025 07:36:39 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 2/4] buildtools: use macro to embed information in
 binaries
Message-ID: <20250415143639.GA16824@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-3-git-send-email-andremue@linux.microsoft.com>
 <b005ba52-afc4-4397-a754-f31c3ecdb33a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b005ba52-afc4-4397-a754-f31c3ecdb33a@gmail.com>
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

On Tue, Apr 15, 2025 at 10:44:51AM +0300, Dmitry Kozlyuk wrote:
> On 15.04.2025 04:21, Andre Muezerie wrote:
> >-_, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
> >+_, tmp_root, archiver, archive, output, *pmdinfogen = sys.argv
> >  with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
> >      paths = []
> >-    for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
> >+    if archiver == 'lib':
> >+        archiver_options = ['/LIST', '/NOLOGO']
> >+    else:
> >+        archiver_options = ['t']
> >+    for name in subprocess.run([archiver] + archiver_options + [archive], stdout=subprocess.PIPE,
> >                                 check=True).stdout.decode().splitlines():
> >          if os.path.exists(name):
> >              paths.append(name)
> >          else:
> >-            subprocess.run([ar, "x", os.path.abspath(archive), name],
> >+            subprocess.run([archiver, "x", os.path.abspath(archive), name],
> >                             check=True, cwd=temp)
> >              paths.append(os.path.join(temp, name))
> >      subprocess.run(pmdinfogen + paths + [output], check=True)
> Does `lib.exe` support `x`? Can't find this option in the doc:
> https://learn.microsoft.com/en-us/cpp/build/reference/running-lib?view=msvc-170

It does not. I'll update this in the next series.

