Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD434C021BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 16:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B561A40299;
	Tue, 25 Feb 2025 17:44:48 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5F64740041
 for <dev@dpdk.org>; Tue, 25 Feb 2025 17:44:47 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9C56C206ADC0; Tue, 25 Feb 2025 08:44:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C56C206ADC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740501886;
 bh=uyXIzvUPx46+UiW+1izkx7Q7xt2uqBGL8MmBpV2OKMk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hsioNqIdGYHp8gVXU/w1q9mBodJtpujsJenmLvUiHazdi55xpn9xiMiJ+we/pHgr5
 XjGmP7+wxIHrY5KEkcwhXlt4NCpqWMu8SD5YZFIyAxXVJdGhQMz+ZJRZMJ+aRe90Hv
 wkHAP/BuyPrl1hIzj4nuTmvPRjNORqlXkdxXkvPY=
Date: Tue, 25 Feb 2025 08:44:46 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Vamsi Attunuru <vattunuru@marvell.com>, dev@dpdk.org
Subject: Re: [PATCH 4/6] drivers/net: make compatible with instruction set
 updates for MSVC
Message-ID: <20250225164446.GB16121@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740430879-17874-5-git-send-email-andremue@linux.microsoft.com>
 <Z72IEgZuYJ4JbCZO@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z72IEgZuYJ4JbCZO@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, Feb 25, 2025 at 09:06:26AM +0000, Bruce Richardson wrote:
> On Mon, Feb 24, 2025 at 01:01:17PM -0800, Andre Muezerie wrote:
> > Top level 'cc_avx2_flags' was created and holds the correct flags
> > depending on the compiler used.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  drivers/net/bnxt/meson.build       | 2 +-
> >  drivers/net/enic/meson.build       | 2 +-
> >  drivers/net/intel/i40e/meson.build | 2 +-
> >  drivers/net/intel/iavf/meson.build | 2 +-
> >  drivers/net/intel/ice/meson.build  | 2 +-
> >  drivers/net/intel/idpf/meson.build | 2 +-
> >  drivers/net/nfp/meson.build        | 2 +-
> >  drivers/net/octeon_ep/meson.build  | 4 ++--
> >  8 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/bnxt/meson.build b/drivers/net/bnxt/meson.build
> > index e26cf13a65..fd82d0c409 100644
> > --- a/drivers/net/bnxt/meson.build
> > +++ b/drivers/net/bnxt/meson.build
> > @@ -65,7 +65,7 @@ if arch_subdir == 'x86'
> >                  static_rte_bus_pci,
> >                  static_rte_kvargs, static_rte_hash],
> >              include_directories: includes,
> > -            c_args: [cflags, '-mavx2'])
> > +            c_args: [cflags, cc_avx2_flags])
> >       objs += bnxt_avx2_lib.extract_objects('bnxt_rxtx_vec_avx2.c')
> 
> I like this change, and the consistency of the variable with the equivalent
> avx512 one. To simplify getting this patchset in - or as much of it as
> possible - can you perhaps add the cc_avx2_flags variable earlier in the
> patchset and make these library changes to use it, ahead of the complicated
> changes in patch 3. I think it may be simplier to have everything but patch
> ready since they should be easy to review and merge, and then we can look
> at patch 3 standalone. WDYT?
> 
> /Bruce

I had added all these changes in the same patchset because they are related,
but if splitting them makes the review process easier I’m all for it.
I’ll replace this series with 2 new patchsets.
