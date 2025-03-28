Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B10C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 15:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18FAE4028B;
	Fri, 28 Mar 2025 16:21:46 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 56CBF4026C;
 Fri, 28 Mar 2025 16:21:45 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 85ACD2025660; Fri, 28 Mar 2025 08:21:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85ACD2025660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1743175304;
 bh=/Oa0HB7jM82kokO7l2On+NM1HagblSc++DBJMePe/1A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DDAMDKNMH8rZbCb6cusT5iyCl8pK6Xq7MgzDUaSbY1xcm/QAYI2EGix1prsrHj8p2
 4C0R+q513glJwYx3VhyC+LV1a1UPfNpwSeMlAnFEvNhkv+JlZxhOGBirdIJMQZGdx2
 iC8uFgHTVw5h5DlKgy2k5ZzeTssr/IfYKKNvqWAE=
Date: Fri, 28 Mar 2025 08:21:44 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 David Marchand <david.marchand@redhat.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, stable@dpdk.org
Subject: Re: [PATCH v4 6/9] net/i40e/base: fix unused value warnings
Message-ID: <20250328152144.GA4330@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
 <20250328111621.2665257-7-bruce.richardson@intel.com>
 <8b72d751-84cc-4ee2-9a81-5c4ba6408b02@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b72d751-84cc-4ee2-9a81-5c4ba6408b02@intel.com>
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

On Fri, Mar 28, 2025 at 02:07:23PM +0100, Burakov, Anatoly wrote:
> On 3/28/2025 12:16 PM, Bruce Richardson wrote:
> >Fix warnings about unused values - parameters, variables, etc., and
> >remove the warning disable flags for them. Although modifying the
> >base-code files is not ideal, the changes required are minor, and only
> >affect two files from the imported base code.
> >
> >Fixes: 8db9e2a1b232 ("i40e: base driver")
> >Cc: stable@dpdk.org
> >
> >Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> >---
> >  drivers/net/intel/i40e/base/i40e_nvm.c   |  2 +-
> >  drivers/net/intel/i40e/base/i40e_osdep.h |  4 ++--
> >  drivers/net/intel/i40e/base/i40e_type.h  | 14 +++++++++-----
> >  drivers/net/intel/i40e/base/meson.build  |  3 ---
> >  drivers/net/intel/i40e/i40e_ethdev.c     |  1 +
> >  5 files changed, 13 insertions(+), 11 deletions(-)
> >
> >diff --git a/drivers/net/intel/i40e/base/i40e_nvm.c b/drivers/net/intel/i40e/base/i40e_nvm.c
> >index 3e16a0d997..56dc4d9279 100644
> >--- a/drivers/net/intel/i40e/base/i40e_nvm.c
> >+++ b/drivers/net/intel/i40e/base/i40e_nvm.c
> >@@ -1743,7 +1743,7 @@ STATIC enum i40e_status_code i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
> >   **/
> >  STATIC enum i40e_status_code i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
> >  						    struct i40e_nvm_access *cmd,
> >-						    u8 *bytes, int *perrno)
> >+						    u8 *bytes, __rte_unused int *perrno)
> 
> I don't think we should be adding __rte_unused to base code, there's
> probably a macro for it in osdep? If not, maybe add
> UNREFERENCED_1PARAMETER in code?

+1 to this. MSVC does not have a direct equivalent to __attribute__((__unused__))
so it makes sense to not expand usage of __rte_unused.

> 
> For other parts,
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> -- 
> Thanks,
> Anatoly
