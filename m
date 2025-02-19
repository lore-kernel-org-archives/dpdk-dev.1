Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE32CC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 14:51:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C05F940EF0;
	Wed, 19 Feb 2025 15:51:31 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EB51240E6E
 for <dev@dpdk.org>; Wed, 19 Feb 2025 15:51:30 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0048020376F8; Wed, 19 Feb 2025 06:51:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0048020376F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739976690;
 bh=rnoxAIRzj2e5o+kSD5jJSBvCW9tdTMvXRdYxDrdkQsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oTLK8YggTHvLUn2YA8Uqk6yVm8XDYAXg8dwpvP+xsSTDURZWAjZ21hJuINgtdyDZl
 7Fb50975Ad9eiqq36131NOnnGGHvxgHAL5mQDkkMRYYF5+aM4zSKYwTjawzzH6XS7V
 q9DvQ47QFEd9P/ItDb2HZi9a+CLKSxyMwRikrf6c=
Date: Wed, 19 Feb 2025 06:51:29 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v2 10/10] app: enable app directory to be compiled with
 MSVC
Message-ID: <20250219145129.GA14242@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-11-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8xSBZrbsfwSW2BmzETom78uSa4ZYEPXoZQgUSTCoo6z0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xSBZrbsfwSW2BmzETom78uSa4ZYEPXoZQgUSTCoo6z0Q@mail.gmail.com>
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

On Wed, Feb 19, 2025 at 10:15:21AM +0100, David Marchand wrote:
> On Tue, Feb 18, 2025 at 5:33 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> > diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
> > index f1c36529b4..8e8863812a 100644
> > --- a/app/test-pmd/meson.build
> > +++ b/app/test-pmd/meson.build
> > @@ -3,7 +3,9 @@
> >
> >  # override default name to drop the hyphen
> >  name = 'testpmd'
> > -cflags += '-Wno-deprecated-declarations'
> > +if cc.has_argument('-Wno-deprecated-declarations')
> > +    cflags += '-Wno-deprecated-declarations'
> > +endif
> >  sources = files(
> >          '5tswap.c',
> >          'cmdline.c',
> 
> We don't need this flag anymore.
> 
> This is probably a remnant of 9f2be5b3db8b ("ethdev: deprecate attach
> and detach functions"), which got fixed later with
> c9cce42876f5 ("ethdev: remove deprecated attach/detach functions").
> 
> 
> -- 
> David Marchand

Good to know. I'll remove it then.
