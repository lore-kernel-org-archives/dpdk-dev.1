Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B7CCA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 19:16:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 163E940684;
	Wed, 30 Sep 2026 21:16:46 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 0082F402DF
 for <dev@dpdk.org>; Wed, 30 Sep 2026 21:16:44 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so44934145ad.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790795803;
 x=1791400603; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tv9VQcR3ayB4f7FRKL3QfSctpwiLThmpG/+nvYPxjBY=;
 b=NbPKipSnAR1zrilVnAufDKlwT9P+fFsf8ZTOXl7HEkDaxegEPmxCzGbdismPmFMhfn
 dH/fl0boUpcsdSFhBo6/nJt3TDJ6EQKNdpKbDmNosd+B3oENojcke3lt/AAFJWlMup43
 wsJv/Yn0+QBU+rFIwAPxF5UUob2j72IusGzo87xPCAFT27vDlPm4X4ooqU1IcnlistUq
 7UxkDmD3+N90UgtquJjSzpWbi9W/FS1uE/RD4V7p95sknD3+PboB0wNbiYc41HSp3KKw
 MfFyrl9orJ9wrZRevfQvV7qr1rMVD6U9lLRZQGKjsUszN5+Df61iSsJjCyqcCUziaseD
 VCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790795803; x=1791400603;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tv9VQcR3ayB4f7FRKL3QfSctpwiLThmpG/+nvYPxjBY=;
 b=n3/Hm16uxrH7w+dwwKRWQbgFXpouA4aH5AETU/d0wRZ7/SEXXElP0DivrDuKi8/Q6N
 NZid6XImm2n78z8Nn+zs7CWqDHlaRR9ZrE6y8+ZOxFyMT8T0f75TKC8o2q3e1a3rv/d1
 Vi62dam/xDS2sohEb+P2RznOHEN6T4O16ebMeRDskxTHV1b0DcQ9kMwLLZMJ/FHHXSS2
 kuPITMftwQoS2OvpDkvWmpG3GpT7AtNySJiK2FCZc1P4tgoaJPyjyAa5ZjGYXqAvDe1g
 XTKBuEohEgF284O9ohOBkA6RlMjmfe+85ENQDQ3gske1lovjNjTrjWwO2mMJanQ/k6fa
 1R5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEK+FWry0TLf+tAsUugUvUV7JkzZckNazBX7Dpq5zAmRakXBIG2/qF4Q/+dQjlQOMPVng=@dpdk.org
X-Gm-Message-State: AFq9FYJIMY3NoC/DIb5LGkia7oFFjYc6sXHznph12l/UrDzNdP3gRZwF
 TjXzbKGu4L0zZVxOdyy+27z67mBLuDUFHtfp7jX/i8Tat8L8opoRSVun66x2bw36V78=
X-Gm-Gg: AYBFou1tGq6AuBiJnofQJXPsSD2aePGy0Y9gakBR1Zv70uRMbTHf7LKu6JZXRJcWq0H
 HjK6iPsEOX1OK5FooWm2NR3rGwI57iwnZWEfNczBu0xRAkhdhF6qCPNtvezl9sq4wBXGDN0b/bL
 dtNrhPJizvGchJTSiLzN+E6LkvAYpjpA54ylej7c/9Zmfjap1yOm2Ip/B0NYE8j7gBjAXivQZCB
 eGj/nSYTupNHe8r/D7HKIZyf4KF0BYCL1Nwp3wlKGy95Jz2aG3uZbRN/Y5gl6KLR5uX5r6ft0Uy
 d/OSkFQsVFMw4iwKpzJaegbkSPbfNAa/0unqk/qR2eyCZc0RaV5md8cjbXTDVyBqHXV9bcXbW+O
 9cn9Tq7xQR4MtQ5gBWddREHRpWOgJp9idiKXwt+2+n7GApAAs+e5G68WbW4EZqFa88Zm3U4O+i0
 f43JI5W57nH6YMG0j4c/qvxubJDc63uBpb0j95+KTz9aiwoNU1HyPvsfE4Kxnt29yKVl7Cirl8K
 hjiguQVRoMTc8nIbegSOkfJg2jIyJc7QC7K0rSJOQ==
X-Received: by 2002:a17:903:283:b0:2e2:e240:57eb with SMTP id
 d9443c01a7336-2e2e4a13fdfmr21459875ad.12.1790795802817; 
 Wed, 30 Sep 2026 12:16:42 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e300b6d7a1sm1541745ad.76.2026.09.30.12.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 12:16:42 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:16:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v18 00/24] NXP DPAA driver enhancements and fixes
Message-ID: <20260930121640.374c9d5d@phoenix.local>
In-Reply-To: <GV1PR04MB107503F62126F240700002EA4898B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
 <20260930062437.3019096-1-hemant.agrawal@nxp.com>
 <20260930090637.1125cc72@phoenix.local>
 <GV1PR04MB107503F62126F240700002EA4898B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
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

Regenerated AI review.

Applied to main (04d091fe4c).  24/24 conflicts in the release notes
context and needs a rebase.  All 24 commits build with -Dwerror=true
(gcc 13.3, x86) for bus/dpaa, common/dpaax, mempool/dpaa, net/dpaa,
crypto/dpaa_sec, dma/dpaa and event/dpaa.  Not built for arm64.

The v16 errors are fixed: the mempool destructor no longer frees EAL
memory, and the O/H port can now be enabled (bus name) and reached
(devargs lookup, "oldev1" parsed).  Also resolved: bman_pool_max is
clamped, a CGR is deleted when its FQ init fails, the byte-count
shortcut is gone, the FQRN wait is bounded, the fq info ioctl moved to
dev_start, OL probe rejects a secondary, the ioctl helpers return
-errno, the VSP ID is bounded before first use, the dma/dpaa param
string no longer has an #ifdef inside the macro, and the FMC parse log
levels are fixed.

Errors
------

Patch 15/24: dma/dpaa: add devargs for SG and errata workaround

  None of the dma/dpaa devargs can be passed.  The documented form is

      -a dpaa_bus:dpaa_qdma-1,dpaa_dma_sg_disable=1

  but rte_dpaa_bus_parse() only accepts fmX-macY, fmX-ohY, fmX-onicY,
  dpaa_sec-N and oldevN.  "dpaa_qdma-1" falls through to the fm%u-mac%u
  sscanf() and is rejected, so rte_devargs_parse() fails with "failed
  to parse device" and EAL init aborts.  The device itself is created
  as "dpaa_qdma-%d" in dpaa_create_device_list().

  This is pre-existing for dpaa_dma_err_check, but this patch adds
  three more devargs that cannot be used.  Accept dpaa_qdma-N in
  rte_dpaa_bus_parse() in a separate patch:

      Fixes: a63c6426fdfd ("dma/dpaa: add option for error checks")
      Cc: stable@dpdk.org

  and test the new devargs end to end.

Warnings
--------

Patch 10/24: bus/dpaa: improve FQ shutdown with channel validation

  The last paragraph of the commit message still describes changes
  that are not in the diff.  Nothing selects "the correct portal" for
  push-mode Rx queues; an FQ on another portal's dedicated channel now
  returns -EBUSY.  Nothing cleans up CGRID or other queue parameters.

Patch 14/24: drivers: release DPAA bpid on driver destructor

  The commit message still says to free rte_dpaa_bpid_info "from the
  destructor instead, once, at process teardown".  The code frees it
  nowhere, which is correct.  Update the message.

  The old dpaa_mbuf_free_pool() did

      rte_free(mp->pool_data);
      bp_info->bp = NULL;

  which writes after free, since bp_info == mp->pool_data.  That fix
  is buried in a feature patch.  Split it out with

      Fixes: 376fb49ecfca ("net/dpaa: prevent multiple mempool config")
      Cc: stable@dpdk.org

Patch 22/24: drivers: add offline (O/H) port device support

  "-a bus=dpaa_bus,drv_oldev=1" is an allowed devargs, so
  rte_devargs_add() switches the DPAA bus to RTE_BUS_SCAN_ALLOWLIST.
  Every fmX-macY port not also given with -a is then ignored, and
  oldev1 itself is only probed if "-a dpaa_bus:oldev1,..." is given
  too.  dpaa.rst shows the two as independent examples.  Document
  that both are required and that ports must be listed, or use a
  mechanism that does not flip the bus to allowlist mode.

Info
----

Series: patches 02 and 03 end a commit message sentence with ":"
  followed by nothing ("returns -ENOMEM directly:", "in
  dpaa_dev_init():").  The quoted code was lost.

Patch 08/24: The stated motivation is push-mode Rx queue shutdown,
  but nothing in the series shuts down a net/dpaa Rx queue by
  descriptor.  The callers of qman_shutdown_fq(fq) are dpaa_sec and
  oldev, and after patch 10 a push-mode FQ on another portal returns
  -EBUSY anyway.

Patch 09/24: With the byte-count shortcut gone, every CGR costs a
  full FQID space scan.  qman_pending_fq_by_cgrid() runs to -ERANGE
  even after it finds the port's own FQ, and close does this
  nb_rx_queues + MAX_DPAA_CORES times per port.  One pass matching
  all of the port's CGRIDs would do.  The "still alive?" debug message
  also fires for the port's own FQs, since close never shuts them
  down before this point.

Patch 14/24:
  - RTE_PRIORITY_104 is a driver-local define in the RTE_ namespace.
  - The new comment in dpaa_mbuf_free_pool() calls the array both
    "shared (hugepage) memory" and "a fixed-size per-process table".

Patch 18/24: A drv_sh_if_name value longer than IFNAMSIZ - 1 makes
  rte_strscpy() fail, and dpaa_eth_dev_configure() silently falls back
  to the fmX-macY name.  Reject it or at least log it.

Patch 22/24:
  - rte_dpaa_bus_oldev_enabled() is exported and has no users.
  - rte_pmd_dpaa_oldev.h is not in doc/api/doxy-api-index.md.

Patch 24/24:
  - The FMCLESS default Rx queue count change in patch 17
    (rte_lcore_count() to DPAA_MAX_NUM_PCD_QUEUES) is user visible and
    not in the release notes.
  - The new experimental rte_pmd_dpaa_ol_* API is not listed.

Pre-existing, not introduced here: in dpaa_dev_init() the "FMC
initializes failed" path does goto free_rx without setting ret, so
probe can succeed with no Rx queues.
