Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A918CC36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 13:51:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D862D40A7A;
	Fri, 11 Apr 2025 15:51:57 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 49A7F4025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 15:51:56 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5E5E42114DB9; Fri, 11 Apr 2025 06:51:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E5E42114DB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744379515;
 bh=bsQUXhvb8D3SeplKw53Vjt74vgqShQjCJSKvfwerpRE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PcCX6hXtSZ+j0QEYtNXyFKV7JyClNcOL6Rnr5CWeOsoCcEDJj0+po8z/LCJ2GOKIF
 95jlvip2jk4T9PoOB5Xb/rDsfqIuuBr3T/bCRKXe16Gj23xhOLVFZMTT16SWZqe2EG
 EOC1nOd3eDAfRdpHG0vcJEz68ZOcdzfbUmS9kghc=
Date: Fri, 11 Apr 2025 06:51:55 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v1] net/idpf: avoid truncation of constant value
Message-ID: <20250411135155.GA16808@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250409125440.7103-1-praveen.shetty@intel.com>
 <Z_aDznlc6Cd7nti4@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wMtW5y+-k=jCUg5RFizbbn1SLbRj8nNicVqrQQK6g_=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8wMtW5y+-k=jCUg5RFizbbn1SLbRj8nNicVqrQQK6g_=g@mail.gmail.com>
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

On Fri, Apr 11, 2025 at 08:52:12AM +0200, David Marchand wrote:
> On Wed, Apr 9, 2025 at 4:27 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Wed, Apr 09, 2025 at 12:54:40PM +0000, Praveen Shetty wrote:
> > > Truncation of constant value compiler warning was reported in clang/msvc
> > > compiler for the VIRTCHNL2_CAP_OEM bit setting.This is due to 64 bit number
> > > is initialized in a 32 bit enum.VIRTCHNL2_CAP_OEM capability is not used in
> > > the present dpdk code,so removing this bit setting from the dpdk to avoid
> > > the truncation.
> >
> > Please just watch spacing after punctuation in commit message. Will fix on
> > apply as necessary, no need for new revision to fix it.
> >
> > >
> > > Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> > > ---
> > >  drivers/net/intel/idpf/base/virtchnl2.h | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/net/intel/idpf/base/virtchnl2.h b/drivers/net/intel/idpf/base/virtchnl2.h
> > > index 3285a2b674..cf010c0504 100644
> > > --- a/drivers/net/intel/idpf/base/virtchnl2.h
> > > +++ b/drivers/net/intel/idpf/base/virtchnl2.h
> > > @@ -265,8 +265,6 @@ enum virtchnl2_cap_other {
> > >        * if a reserved bit is set in a standard completion's tag.
> > >        */
> > >       VIRTCHNL2_CAP_MISS_COMPL_TAG            = BIT_ULL(20),
> > > -     /* This must be the last capability */
> > > -     VIRTCHNL2_CAP_OEM                       = BIT_ULL(63),
> > >  };
> > >
> >
> > Although technically perhaps not as good as [1], this avoids significant
> > divergence from the shared base code, while still fixing the core issue.
> >
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> >
> > [1] https://patches.dpdk.org/project/dpdk/patch/1734537913-1159-1-git-send-email-andremue@linux.microsoft.com/
> 
> LGTM.
> I marked Andre patch as rejected.
> 

I'm good with that. My main goal is to get this code to compile with MSVC.

> 
> -- 
> David Marchand
