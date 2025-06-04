Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF3EC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 13:59:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 281AD42D80;
	Wed,  4 Jun 2025 15:59:30 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 25084427DA
 for <dev@dpdk.org>; Wed,  4 Jun 2025 15:59:29 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 77014201FF51; Wed,  4 Jun 2025 06:59:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77014201FF51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749045568;
 bh=z+FId/bk3Rb3Wusk5AAnjI1HUyuZ2UsObXUBFN1ZSeI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=flWsT/1eW5IcMpPQbLyjgbF2DkpKLdCay3W/yL2oMn3U9prztjN5iLNxKEE38wZZ+
 Ul5LftW2gkB+mMhLW18VxbnTmO7upD+rxg2lFAKE2J677xye/LsIrs3QK2BHsuEUxE
 GA1t1Nhka0q8yJz7AU96+Wo3BZK6VOBBfhz8NkNs=
Date: Wed, 4 Jun 2025 06:59:28 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 2/4] buildtools: use macro to embed information in
 binaries
Message-ID: <20250604135928.GB4412@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-3-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8zTWGCt41_oqpHktfNJ1s6n9iFbJjwCJPPoKuWJamg0QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zTWGCt41_oqpHktfNJ1s6n9iFbJjwCJPPoKuWJamg0QQ@mail.gmail.com>
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

On Wed, Jun 04, 2025 at 01:04:29PM +0200, David Marchand wrote:
> Hello Andre,
> 
> On Wed, Apr 16, 2025 at 11:45 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > The archiver tool from the MSVC toolset is lib.exe. It has different
> > parameters then it's GNU counterpart "ar".
> >
> > buildtools\meson.build was updated to use lib.exe when MSVC compiler is
> > used. This is to allow the code to be built without requiring GNU "ar"
> > to be installed in that scenario.
> >
> > Script gen-pmdinfo-cfile.py was updated to use the correct parameters
> > when using lib.exe.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  buildtools/gen-pmdinfo-cfile.py | 24 +++++++++++++++++++-----
> >  buildtools/meson.build          |  4 +++-
> >  buildtools/pmdinfogen.py        | 11 ++++++-----
> >  3 files changed, 28 insertions(+), 11 deletions(-)
> >
> > diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
> > index 5fbd51658a..3a078ab6d1 100644
> > --- a/buildtools/gen-pmdinfo-cfile.py
> > +++ b/buildtools/gen-pmdinfo-cfile.py
> > @@ -7,15 +7,29 @@
> >  import sys
> >  import tempfile
> >
> > -_, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
> > +_, tmp_root, archiver, archive, output, *pmdinfogen = sys.argv
> >  with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
> >      paths = []
> > -    for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
> > -                               check=True).stdout.decode().splitlines():
> > +    if archiver == "lib":
> > +        archiver_options = ["/LIST", "/NOLOGO"]
> > +    else:
> > +        archiver_options = ["t"]
> > +    for name in (
> > +        subprocess.run(
> > +            [archiver] + archiver_options + [archive],
> > +            stdout=subprocess.PIPE,
> > +            check=True,
> > +        )
> > +        .stdout.decode()
> > +        .splitlines()
> > +    ):
> >          if os.path.exists(name):
> >              paths.append(name)
> 
> Indent after the change seems strange.
> 
> And we need a rebase of this series in any case.
> Please send a new revision.
> 

I rebased the code and formatted it using Ruff. I agree that the formatting
looks substantially different than the original code and it takes a while to
get used to it, but an argument could be made that the new formatting looks
better.

> 
> 
> -- 
> David Marchand
