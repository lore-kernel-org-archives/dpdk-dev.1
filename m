Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70A5C982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:19:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43A5342E1C;
	Thu, 17 Sep 2026 18:19:49 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 5FEB9402D3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:19:48 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc1cea50db3so689044a12.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789661987;
 x=1790266787; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wd8+oI5i9VK4evrz2xZ0s6oewDgVSCCcETkjILh0sPo=;
 b=Bcjf8A8gnVSR9vgprw8mDEdiHG5SpP8Bq9TgB70Ih4IqDNlmS3jaB5u0zdAOxd1ce/
 inGuDPEWFYy0/0nJ2bqfLZ0DMByZsxi4vkrguDof0DCRblBfVLvWP6K1dUazXi+9PMU4
 ivEZve57+nQNDIVmAnC9pSWoKnDdkRVqfzNaToS3x2n1gg7WQwq3QS0buCwr/j3fi+hv
 g5Ew4PcvqMpgMb4Zpc7IV7uRcFDn7SwVUeooD8SZN44iQ1f3fuaaB6bwckTfxI7IIg+z
 KxU/LM6QH94efTIPza95zWS/n20clYM9QgRH8RTCs8qvcV1S+Yf3PJ/+4qaa01tXyAWI
 OVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661987; x=1790266787;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wd8+oI5i9VK4evrz2xZ0s6oewDgVSCCcETkjILh0sPo=;
 b=Cwb4Mjt7rrymwVhmSuoJfQcL9IVneGSatzL9P4vZjK7l8qzp/kOQufuG645RswDIFS
 OKK4gWn4i8kJiWFtlAykCj4PtOy8gZ1ux/HBvvibC9cbETPZ/bPlfDRWmEi6xLgTkDqC
 YutWrzhHvSN19+fSdCIzzZrQlhGyqpsHtOIlw2Lo0HPrE+bVK7g8QTKrknZ7K42YP507
 L6HtRMSspfiLes3arfW64btK+fa7WcwdrbyAcQF3as1eOUxvbaim361MEBsvx90y0iPv
 5OC2W06aZCIxDdz9NVIHSPTaxad/tjMdVQufNob5mFnHBuzNH0LMT04G/3vkfJOj180o
 0uPQ==
X-Gm-Message-State: AFuF++lNK486myHcS0PwXQ/yWn7SkWa0nHlHpdCEtwRKJQbUl3lPE7JJ
 RZXdTGUuaV5YcQpaGrwAdIO/m92bFWyV45v/9QQkX/+3i4x3daX8BIJWMJEGB8kuMcA=
X-Gm-Gg: AYBFou1EjkwNBS2OGvzW5s+ASUMSOKsf3DHXXrrA/R/xLtkVymXieqSlFV//hTJ4vuJ
 1X5zPtFN07PsZupVqO7jnvc9e4faFtDdIN6GcYKecKEXuY0WPcEmbdno2xovw2Plbg5RZvf6GeK
 f3gA3dXjpTpkPFkVZ9jZZ0FAajiKKKaac6ac+OV25C0u7CE7izWwc6dq7mSeOF1RBGKDcnhe+0i
 +6ounZmZZYwHRAxWlqrih1DwmLPS+Bzh6HjztgiwSxrSf6R9Gg4sBRhE+ep/qlnH1PNt4Q93jnE
 jcos6DjlYfbzx4Wkl2TPz0sSR6ceWKIx0VBfs4gy9RdXrqqsS9MTwH4QqlhHueUn/Y/FwEK5QoI
 hcf1DzzJKWh/e/SKU52BBAimxwhqYTtEX3PCEy373YYlLBa9BxmYZtleMbkVdEqc8cn7TSNfYAM
 WvA4M9qqgcadNQ12E5hzfnUxCHqGNf9VMMwDYdTCbLhqBdq4iPwHPOskcimz3oV+2owMy+Arary
 buZYO051eaoYrixZxZC8xAohKYqSBqn4qk5HdFH
X-Received: by 2002:a17:90b:1b06:b0:39e:3713:c2e4 with SMTP id
 98e67ed59e1d1-39e3713f4e8mr8423333a91.14.1789661987405; 
 Thu, 17 Sep 2026 09:19:47 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3c06423esm4824952a91.15.2026.09.17.09.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:19:46 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:16:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: Re: [PATCH 10/14] net/cnxk: add MSNS inb SA and CN20K CPT result
 struct
Message-ID: <20260917091655.57910320@phoenix.local>
In-Reply-To: <20260917071016.2366467-10-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
 <20260917071016.2366467-10-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 17 Sep 2026 12:40:12 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> 
> Define the 1KB inbound MSNS SA layout with four packed anti-replay
> sub-spaces, the MSNS context update region, and compile-time size
> checks. Extend the HW SA union and add the CN20K CPT result format
> for inline IPsec custom profile support.
> 
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> ---
Patch 10/14 net/cnxk: add MSNS inb SA and CN20K CPT result struct
----------------------------------------------------------------
Warning: undocumented API change in an installed header.
- ltype_mask, ltype_match, lid, noffset and offset are removed from
  struct rte_pmd_cnxk_rx_gen_inl_cfg in rte_pmd_cnxk.h.
- That struct is embedded in rte_pmd_cnxk_profile_cfg_params, used by
  rte_pmd_cnxk_nix_inl_custom_profile_setup() (experimental, 25.11).
- The removal is source-breaking and is not in the commit log.
Split it out and add a release note.

Warning: rte_pmd_cnxk_inl_inb_prof_sa_base_get() now returns the
default IPsec SA base when profile_id == UINT16_MAX. Neither the
Doxygen ("Custom profile ID to get the SA base for") nor the commit
log mention this.

Warning: a new typedef is added already marked @deprecated:
  typedef struct rte_pmd_cnxk_ipsec_inb_msns_sa
          rte_pmd_cnxk_ipsec_inb_sa_msns;
Drop it.

Info: RTE_PMD_CNXK_IPSEC_INB_MSNS_CTX_PUSH_SZ(x) is an identity macro,
and RTE_PMD_CNXK_IPSEC_INB_SA_MSNS_SZ_ALIGN duplicates
RTE_PMD_CNXK_IPSEC_INB_SA_MSNS_SZ.
