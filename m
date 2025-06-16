Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EEEC71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 15:09:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BBC5402BC;
	Mon, 16 Jun 2025 17:09:47 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 02A174021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 17:09:45 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0D03D211518B; Mon, 16 Jun 2025 08:09:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D03D211518B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1750086584;
 bh=Puv4iIPjiSe/4POPkzDOETTJ2uVTgCnArQrYaQeBDFo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xs4qXCQjP6VBx2HfemdyBpqkWZ9/Seb4x2jauO/wtvgDovt6Ow/zpsLVK9IkoKDxw
 zkUf5RWcRPe2mszDQvIkZy51Emhl4r28o8VLyHdcMryUKup8MGxuW1aaq8K78uMo5a
 wa53aD2qh5bx2rS+EMp+m4XzsQ0LyWNiBtgfzdvQ=
Date: Mon, 16 Jun 2025 08:09:44 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] buildtools: allow a different minimum meson version for
 Windows
Message-ID: <20250616150944.GA20062@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749831278-8286-1-git-send-email-andremue@linux.microsoft.com>
 <aE_Jf9p5HY17jc1M@bricha3-mobl1.ger.corp.intel.com>
 <aE_VVNiio9Ewz-h2@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aE_VVNiio9Ewz-h2@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, Jun 16, 2025 at 09:27:00AM +0100, Bruce Richardson wrote:
> On Mon, Jun 16, 2025 at 08:36:31AM +0100, Bruce Richardson wrote:
> > On Fri, Jun 13, 2025 at 09:14:38AM -0700, Andre Muezerie wrote:
> > > There is a minimum meson version specified in the DPDK meson project
> > > section, which has been documented. This string is parsed by
> > > buildtools\get-min-meson-version.py and this information is used by
> > > lab automation to install the corresponding meson package on the
> > > build machine.
> > > 
> > > Turns out that the meson version specified on the DPDK project
> > > (0.57.x) is buggy on Windows: it has issues related to path
> > > manipulation, and these issues are causing failures. Therefore,
> > > a newer meson is required on Windows.
> > > 
> > > To avoid bringing the minimum requirements up for all operating
> > > systems before a more appropriate release, this patch implements
> > > a mechanism allowing a different version to be specified for Windows.
> > > 
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > 
> > I am fine with the principle, few comments inline below just on the
> > specific implementation.
> > 
> > /Bruce
> > 
> > > ---
> > >  buildtools/get-min-meson-version.py | 12 ++++++++++--
> > >  meson.build                         |  9 +++++++++
> > >  2 files changed, 19 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/buildtools/get-min-meson-version.py b/buildtools/get-min-meson-version.py
> > > index f0de8fdf2b..10a2596a5a 100755
> > > --- a/buildtools/get-min-meson-version.py
> > > +++ b/buildtools/get-min-meson-version.py
> > > @@ -11,12 +11,19 @@
> > >  basedir = dirname(buildtools_path)
> > >  
> > >  with open(join(basedir, "meson.build")) as f:
> > > +    if os.name == "nt":
> > > +        keyword = "windows_meson_version"
> > > +        pattern = r"windows_meson_version:\s*'>=\s*([0-9\.]+)'"
> > > +    else:
> > > +        keyword = "meson_version"
> > > +        pattern = r"meson_version:\s*'>=\s*([0-9\.]+)'"
> > > +
> > 
> > Minor nit, but I'd suggest shortening this a little to:
> > 
> >     keyword = "meson_version"
> >     if os.name == "nt":
> >         keyword = "windows_" + keyword
> >     pattern = fr"{keyword}:\s*'>=\s*([0-9\.]+)'"
> > 
> > or even further shortening gives:
> > 
> >     keyword = "windows_meson_version" if os.name == "nt" else "meson_version"
> >     pattern = fr"{keyword}:\s*'>=\s*([0-9\.]+)'"
> > 
> > >      for ln in f.readlines():
> > > -        if "meson_version" not in ln:
> > > +        if keyword not in ln:
> > >              continue
> > >  
> > >          ln = ln.strip()
> > > -        ver_match = re.search(r"meson_version:\s*'>=\s*([0-9\.]+)'", ln)
> > > +        ver_match = re.search(pattern, ln)
> > >          if not ver_match:
> > >              print(
> > >                  f"Meson version specifier not in recognised format: '{ln}'",
> > > @@ -24,3 +31,4 @@
> > >              )
> > >              sys.exit(1)
> > >          print(ver_match.group(1), end="")
> > > +        break
> > > diff --git a/meson.build b/meson.build
> > > index 5ff68cb3af..1ae51996be 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -13,6 +13,15 @@ project('DPDK', 'c',
> > >          meson_version: '>= 0.57.2'
> > >  )
> > >  
> > > +# Meson does not support dynamic/conditional values for meson_version in
> > > +# the project section.
> > > +# The line below contains the minimum meson version required on Windows,
> > > +# which gets parsed by get-min-meson-version.py.
> > > +# It is important to keep this line below the "project" section, so that
> > > +# the script can make the correct determination according to the operating
> > > +# system.
> > > +# windows_meson_version: '>= 1.5.2'
> > > +
> > 
> > Why not pick a string that is not a superset of the general meson_version
> > one? That would avoid the need to position it below the project one, and
> > save you having to document that in a long comment. (also avoid the need to
> > add the "break" into the python script, not that that is a big deal!)
> > For example, how about using:
> > 
> > * windows_min_meson
> > * windows_meson_ver
> > * windows meson_min_ver
> > 
> Or even: "meson_version_windows", since the rest of the pattern we look for
> occurs after this string.

I like the 'meson_version_windows' suggested and will send out an updated patch
along with the shorter syntax.
I'll keep the "break" though at it will still be needed to avoid a match on
Linux when "if keyword not in ln" encounters "meson_version_windows". That
break makes sense as there's no point in parsing the rest of the file once
the line we're looking for is found.

