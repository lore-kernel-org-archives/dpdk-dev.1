Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8BBC982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:19:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CCF8427B2;
	Thu, 17 Sep 2026 18:19:03 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 1BBB242796
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:19:03 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so923570a91.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789661942;
 x=1790266742; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z7M1/UwCLTXU+LjfO/cg7Is7MPFbquwB/xObfFaDQB8=;
 b=GQD0EJewENrn2KsCMn8EJZ0TjzW7tksOpD1BgqPzuwsoLgdNqUmZtCXujzOBr/9Mn8
 vRL90u57mbx6w1h9BkOeCg+zJQhoR+CG6dGxyFDPBsJhjtC7hq0fq8+KLd2M0OSetr6T
 7KaYde5nMYViYIhq9vzh92cESFZ8/6ai3rDgkSQisCM8aF+DcjD7j49g2Jth2uNfpOzc
 pk3bgaAyR5DNdrU2kJV1c2WDat7j4l7Xybg5QVVjsRCbHNala/7zOf4AgVMySaU+xEM0
 fbdyArK6Is4sxo5iXpeofU01zUMmMtg9VrgV3qTRTHhvpD21Uuer+GlhDQc2I+J4qee0
 I0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661942; x=1790266742;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z7M1/UwCLTXU+LjfO/cg7Is7MPFbquwB/xObfFaDQB8=;
 b=xgPorcw348Q5O0Qq58sc9nh4ZcMeA1E/oI6pOhj31HdLGcnRjOB0LeSuawQL6SFbBD
 6DOmUhMZOxj25VRX8Cqkd511jfmcmImtjHtlMhoTTPRZq5cThh093GiHBRyhwUe4fgn8
 rfdz4GkhLwF9gRmf20H065htYju1XJodIjETpbqbOSkC7yR657F7N8C3fVewxCGjFiO9
 8X+tPTrN8BWbMqEMLKabd3+J+Yjwpe0/5madi9f5VegvwekCTiEiX+h342vJpolZiUMY
 K6KakvUyhmNWTXfUtLnHAWxy39pUjJbbuSawNNYqr1nfTBjkTAD3BWq/winmEdjEweaP
 A9QQ==
X-Gm-Message-State: AFuF++mvoZGf8i+NruhxkscNkaB7Ye0zysISCz1ZHPl8WQpJXiqnoN+3
 vPa/NOMEe7u3PIKEoJOB3z8CReAqTClVNpJisQHhatP4l6cJKtm39z6+iT/vE1xU7CQ=
X-Gm-Gg: AYBFou33yx2lY7uojWkqi7zwNgqOHgROTNEs+qOMd9xp0GQxMAsfydtY3Bzd1KM4msc
 gk82d4cqziab7YLqg28ZgI+Wul1qE+FAcy1J2JvqYXMk8+C5p55tBCza0Gfxh2y3jP4eP0mqS+Z
 acRpSaKjNn1FwYBrbCu07xcSnrcU6cjaYjveNXsnNbwIy4xUK4ib1v3hk6jLjrP3BhaFQ2E2roD
 z7TLOouNYvI9jM0J3WwuP+plrLnQW20ubOHNiYrqgSyzm4Sg2z1fvedpOfWkPDPEe4wm4Pq483D
 EvZBlz1XRFYieqsxba50WQXhapX8N7g+9iJTjc+T8Qv30VAUpdNJMKtHk7CHbD1zvJPM4EtD9k7
 hMzKNm5RYG/tHRJPx0AlctF8iHM9aBx+NAV4pRG+AIxBUZUGof5g48yMcYgfkGKV2C+tshdIe7B
 uDy1F6YXshYL76pjPXTpTdwGDOWe5Y4VBMVKoatnpbJMJIbJh2pgEonEWG180BcNq53riMcZWCZ
 RcvVp//lxJkLCrZkKJuc09A74wd9xP18ntgAZSY
X-Received: by 2002:a17:90b:3842:b0:39d:f6a6:60d8 with SMTP id
 98e67ed59e1d1-39e1e23e8bcmr15075428a91.3.1789661942175; 
 Thu, 17 Sep 2026 09:19:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3c06423esm4824952a91.15.2026.09.17.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:19:01 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:18:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: Re: [PATCH 13/14] common/cnxk: support for cn20k legacy msns mode
Message-ID: <20260917091813.2d8436ac@phoenix.local>
In-Reply-To: <20260917071016.2366467-13-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
 <20260917071016.2366467-13-rbhansali@marvell.com>
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

On Thu, 17 Sep 2026 12:40:15 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> Update nix_rx_action2_s for legacy msns mode support for cn20k
> 
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> ---

Patch 13/14 common/cnxk: support for cn20k legacy msns mode
-----------------------------------------------------------
Error: roc_nix_inl_ctx_write() no longer rejects oversized inbound SAs.
- The check "sa_len > ROC_NIX_INL_INB_CUSTOM_SA_SZ" now only logs at
  debug level.
- It then goes on to memcpy(sa_cptr, sa_dptr, sa_len) or
  roc_cpt_ctx_write().
- With custom_inb_sa, nix_inl_inb_sa_tbl_setup() sizes each slot as
  ROC_NIX_INL_INB_CUSTOM_SA_SZ (512).
- sa_len comes from the application through
  rte_pmd_cnxk_hw_sa_write().
- A 1KB MSNS SA written there overwrites the next slot.
Check against the slot size of the owning table (inb_sa_sz[profile])
instead of dropping the check.

Warning: roc_nix_cqe_dump() now reads past the descriptor.
  for (i = 0; i < ((rx->desc_sizem1 + 1) << 1) + 2; i++)
The datapath (nix_cqe_xtract_mseg) ends the SG list at
  (rx + 1) + ((rx->desc_sizem1 + 1) << 1)
so the dump reads two words beyond it. No rationale is given.

Warning: the log says "Update nix_rx_action2_s", but hw/nix.h
struct nix_rx_action2_s is unchanged.
- npc_action2 is built from raw shifts (<< 7, << 17, << 32, << 48).
- Those land in fields the struct still marks reserved.
Update the struct and use it.

Warning: unrelated changes are bundled into one patch.
- roc_cpt_cq_dump(), which has no caller in the series.
- The cqe dump loop bound.
- Removal of the ctx_write length check.
- roc_model_is_cn20k() -> roc_feature_nix_has_inl_profile().
Split them, each with its own rationale.

Info: roc_cpt_cq_dump() prints "uc_info \t0%" PRIu64, which is decimal
with a literal leading 0 and reads as octal. Use 0x%" PRIx64.
