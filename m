Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2E1CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 16:39:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9D8A402E7;
	Fri, 16 Oct 2026 18:39:12 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id A860B4026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 18:39:11 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8875d220446so84000b3a.3
 for <dev@dpdk.org>; Fri, 16 Oct 2026 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792168751;
 x=1792773551; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=65vTYnnbDPUjJk4rGtuy7F+GwpXeOcXihMXdcDzz0+8=;
 b=0FcU8htfc9cxaqtZbv3E+HZIohhQe0t7s48JisKhOi5sqzPkjpZIIo2Hfpe3ZZwSh3
 voZ7UTjNW8mOc/dlcQPF4g2FcuQeAgJgSbq22IMz9MsU8yLffWnMI2+3ihLl9YOgxVbH
 ADav8tYsXAwdWFFxCzrSEERLXBXqyM6NL0JUQMghXIPpTXhsRjXlTiAP7HUE0z9/UtPv
 Aft+M0oEbJj1g07lzaF3kaB7jNoO4Dy437FpU/6Dcaoy1tjJwcPJknZLECyRh4+89Z+g
 lG9EussRFrNm2PcTYDCUWRXA71lFme/FuiLuTVz+9NGf1hPkMaskXEjq9QrkxA4rGQyV
 6yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168751; x=1792773551;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=65vTYnnbDPUjJk4rGtuy7F+GwpXeOcXihMXdcDzz0+8=;
 b=wwctKLTFv0kIiD/h93NuwQsa1ZCAD27klY9J1bR96dh6XMCcOsyQMbzyIc8FjPmhX6
 SjoayRbR5BxbF8h+JPf6JidjhxbCCjo7N7u94ZVkY7d7khzYh05uTzB5+ZZ1pAg+3GMW
 x/0AuFGEQTqlcRwYxi1NILquOXhh2o2oH2tTDpGBX/Vad8XgOtoTku3ScQj8Qxy40+JR
 79Iwzqdd6nQ7Z4w+B88tKI9BJsVdB07ciFVOdBSwlnumSycS0I26ncDrLG4CB90ns+OU
 ikMSwhQr0rq9cHr6JWP0Ez7hm4bJsl6h8eIlG45ZC/dsEglQIwEzYLWN3e7wMSebM+nr
 JuNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/t6d6nGwxg/jEijus6r8y6NbphCbSjDARdxq1geQf/zZaeiPBNWqxqp2fS3ygYiafo54=@dpdk.org
X-Gm-Message-State: AFq9FYICoGj5p6KtE4cFU2wNjCRMBDKYxin5nLGP1zTH0zgd7lsH/fQ8
 tyK9pq1QsYVe0aIyhzjujtbpGPiltSZPD/2ymhPo0aMaMVq3eDrpU8ZMyuDWOQ+sAjA=
X-Gm-Gg: AYBFou0xA6MylvLUsYTIy926DMNj0ZuNBGcIofuaPJJqR4JqPVkXgafiH6ae20W9k5u
 OqBGutixa4jM0ILuzgS+5NGPpzAe+24JDfrVcMf05uunCc+rZw37EGSh7vUVTtaGX3WkTUw+NDD
 1uXItsmWZDOswXEJswS1sTPH000NzVcFgL1gU3s+CBGjZ14xthk3JbspJ4kemKkFDKYQQ1xH4pp
 GyZkACmptAMAvF0Dc5t/ImECdzhs+sZ5iRdpUYeQerzSPZ7+84dZYAP//bgxWhLW6QxzPVXjwzi
 cDcJujYSjK3OhVw30rJN/PuwP+Nb++0RAZF+tLYImY6OK7ynQNzNE6hUMz+eX9IlUIb9JrMKuyB
 bttjLTrFHNbmNQGWtPC4s42W9gkZzeKbcByK9IJki0wd0e48YzhWOZHb6s9E7Bpap2MS4qvwvzo
 lQEQ+B0n4+/PgDGbYSaRwphysOSW2YWpI5vKx+e7aivK7Enk0FwRBl/PGD/2MLxkFmDarLDJQ6P
 MwDKCdiSl3Xi5Dl7evFc0MBcXMA8/9a3T5RU5QMK3C4Ov+moIg2
X-Received: by 2002:a05:6a00:4515:b0:892:a4c0:4eb1 with SMTP id
 d2e1a72fcca58-8a04b712bddmr102422b3a.18.1792168750637; 
 Fri, 16 Oct 2026 09:39:10 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57947fb2sm1422185b3a.37.2026.10.16.09.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:39:10 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:39:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v27 00/25] NXP DPAA driver enhancements and fixes
Message-ID: <20261016093848.7dbe6c73@phoenix.local>
In-Reply-To: <20261016111958.163060-1-hemant.agrawal@nxp.com>
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
 <20261016111958.163060-1-hemant.agrawal@nxp.com>
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

On Fri, 16 Oct 2026 16:49:33 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
>  
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue shutdown, secondary-process
> safety guards, BPID lifecycle handling, and several new features:
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration, non fmX-macY shared Ethernet naming, and DMA
> scatter-gather and errata-workaround devargs. Documentation and release
> notes are updated accordingly.
>  
> V27:
> - fixed qm_channel_pool_num check issue.
> - fixed commit message as devarg for fmcless rxq number was removed.
> - Added missing export internal symbol and fq destroy.
> - merged both FQ shutdown patches as we cannot change the sequence
>    because of the dependency.
> - mac_idx has a user which is dpaa flow so no change. Added static to
>    g_fmc_model and updated release notes.
> - Issues reported in v25 which are not handled, were optional, so
>    skipping them.


FYI - what I do is feed the patch into a Claude project with existing
AGENTS.md file. The chat continues as versions get sent to email so
the context window has all the versions of the patch. This lets it see
the progress and check if previous findings were addressed.

Review of [PATCH v27 00/25] NXP DPAA fixes and enhancements

Series applies cleanly to 26.11-rc1 and every commit builds with
-Dwerror=true. The fixes are now first. 08 cherry-picks cleanly onto
v24.11 and v25.11, and 06 applies there once 01-05 are in.

v26 Warnings on 12 (now 14) and 20 are addressed. The 24 Warning is
only partly fixed.


Warning
=======

[PATCH v27 24/25] drivers: improve DPAA crypto fq resource handling

The lookup table slot is now freed at the end of qman_shutdown_fq():

  if (!ret) {
          fq->state = qman_fq_state_oos;
          qman_destroy_fq(fq, 0);
  }

That block sits before the out: label, so the early exit for an FQ
already out of service skips it:

  if (state == QM_MCR_NP_STATE_OOS) {
          DPAA_BUS_DEBUG("fqid(0x%x) Already in OOS", fqid);
          goto out; /* Already OOS, no need to do anymore checks */
  }

Of the RTE_DPAA_MAX_RX_QUEUE (4096) inq[] FQs, dpaa_sec_dev_init()
only does qman_create_fq(). qman_init_fq() runs from dpaa_sec_init_rx()
when a session attaches, so almost all of them are still OOS at uninit
and in the init_error3 path. Their slots still leak, about 4096 per
remove/probe cycle, and still point into the freed dev_private.

Move the block below the label so the OOS exit is covered too:

  out:
          if (!ret) {
                  fq->state = qman_fq_state_oos;
                  qman_destroy_fq(fq, 0);
          }
          return ret;

This also changes qman_shutdown_fq() for every caller, so say so in
the commit message: a successful shutdown now releases the FQ's lookup
table slot.


Info
====

[PATCH v27 09/25] net/dpaa: prefix fmlib device helpers

Making g_fmc_model static is not in the commit message. Unused
mac_idx[] is still global in dpaa_flow.c:

  const uint8_t mac_idx[] = {-1, 0, 1, 2, 3, 4, 5, 6, 7, 0, 1};

Remove it here.

Still open from v25, unchanged, optional:
  04  pre-existing: dpaa_dev_init() error path frees cgr_rx/cgr_tx
      without qman_delete_cgr()
  14  QMAN_MAX_FQID, QMAN_CHANNEL_PME and QMAN_CHANNEL_PME_REV3 unused;
      dpaa_get_qm_channel_pool_num() needs no export
  17  FMC_PORT_NAME_OFFLINE branch unreachable
  21  bm_buffer_get64_from_be() should be a static inline function
  24  fqids[RTE_DPAA_MAX_RX_QUEUE] is 16 KB on the probe stack
