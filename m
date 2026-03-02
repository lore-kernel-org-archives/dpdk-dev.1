Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B84EB3621
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 17:11:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 101464025F;
	Mon,  2 Mar 2026 18:11:34 +0100 (CET)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 1E088400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 18:11:33 +0100 (CET)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2ae3a2f6007so14773795ad.2
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772471492; x=1773076292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8RNCOLWL423PWnrgpepCxs1MuGPE7s//23lHk/PEj9M=;
 b=G7YByNXv6FF7g/mM3QusdD7bgljNumk4/r4qFkA95VAiiBBj97/kGEuO/BY8XVGOV6
 jZ6d0iCf5fw3O8mLzrQ8cC4+4xteelidL5H2jPuQuPhhtywp3/c1NLNeuTVlaVVCOOYR
 o8DbcBIl6FEVYprwmiWQfonTOGLQMwTB70sRNP0gSxsz8cxhd+TqIxOs0vaRJqmMnyZs
 PwCp56CH1SvLATOhOGnseq7gl2mSLycjCvH1ryuXjx/4dCAfuZD3AYJ3iLCCwklr+s0u
 X3W/4Q7f8yGzr5vMSg/xsnWTB2s6+K0VPdWaFYgkay5/4jHvRfFO8pSpNfRTn/r7HkS6
 KW9w==
X-Gm-Message-State: AOJu0YyPr7gasWeaBRTcLkVWYHT9AnI+9K2DoKvxcOdMiQ4PCz9DCARE
 Yui6IS0Do/NRpI/es2GnLsXyPeZuUe5lv0odggvuOUlhuuEna+3vfnPc/Vsif8j6liGog2ThXLM
 QyJOnbI2V28DxMvc/53cv2WtjLSKqWSbYvRvDvOQuu6ZsUQaav8OX5TyxvU2ayUgdGXe8UkEG/x
 DM44eBJRrEuLZkCnBq8Q4cVt/kwr9UKq4aoP2Bh1TA81YfMuglfeEegXwsJ4nbohQawqTLeT5sQ
 GjHYU32XqZX
X-Gm-Gg: ATEYQzwvz1NER8VxXjVobG1DySGn6mcQBMEF3eRzUgZ6abt1ZCkgQpK95+6IQUCidGx
 HAJiuEt2R+EdS4NN40nAEKCQYVXm3QseANjM7kQdtT8QZheWyKEgoor4OBtyUWjvRCNmtfrPZVA
 TtyqYuOIH5pT9C6waB9uHQZTpi/2iw4cFA9fSmac0Bbxa3EV6BVqBKO0VPH3XjV1Js8vVYIu3uS
 Qxa1GxLAidZkZxmJTAdQvSPYdYCX8OIyBUSTo124W8KJskzFN9757mK3KD/9A8boS2dQU0zV+8j
 dukbGSGQG4olt5K0e8/Yr/zVLHTTQaJ641HQBN3EQkeeP54rDj8ee920OfbRXtQ/bqgdlDK3yc4
 jI8cx3DCTl4MKEYucQb7DcD92DTFccY+asRXa9v2kHqpdXnFOxnFWPuO8IDnMsc6P8I/wQ3LOMp
 toXXEgXGJUPt8XawShGb6/Ii35sjRWXmn7V++jv2y9a2YZ4x8m5Q2czR2Hz0PG9E6WRuiZiG0qx
 A==
X-Received: by 2002:a17:902:da8f:b0:2a9:5e25:46f6 with SMTP id
 d9443c01a7336-2ae2e401cbbmr127304305ad.17.1772471491797; 
 Mon, 02 Mar 2026 09:11:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2adfb5fbfc2sm17344905ad.48.2026.03.02.09.11.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:11:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1275c6fc58aso9731255c88.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772471490; x=1773076290; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8RNCOLWL423PWnrgpepCxs1MuGPE7s//23lHk/PEj9M=;
 b=dbj0FsG+aHYQ3qUllgXg49i440oSpa2d8RqgPEtUl6xHRnlSd8nBCtlqF8vB9gJIT/
 TeZqgP4+FIdSnxI5WoM4fo81k4OJmBTKJaXDWfFrD7kVoBOFlMPUIpoqoZVUCHbLR2Qc
 aI9sn58jWqlkGBNNaUKmhJ66MEu2wyjSralPo=
X-Received: by 2002:a05:7022:6713:b0:123:35cb:96e3 with SMTP id
 a92af1059eb24-1278fc6bee0mr5744055c88.46.1772471489890; 
 Mon, 02 Mar 2026 09:11:29 -0800 (PST)
X-Received: by 2002:a05:7022:6713:b0:123:35cb:96e3 with SMTP id
 a92af1059eb24-1278fc6bee0mr5744032c88.46.1772471489001; 
 Mon, 02 Mar 2026 09:11:29 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789962f89sm13910511c88.0.2026.03.02.09.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 09:11:28 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 0/4] net/bnxt: PTP support series
Date: Mon,  2 Mar 2026 10:12:32 -0700
Message-ID: <20260302171236.98625-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

This series adds and extends PTP (IEEE 1588) support for the BNXT PMD:

- Patch 1: Support handling of PTP frames in the Rx path (scalar path),
  including ol_flags and packet_type updates for PTP timesync packets.

- Patch 2: Pass Rx timestamp to the application via the mbuf dynfield
  and add ptp_cfg NULL checks to avoid segfault when ptp_cfg is not
  created.

- Patch 3: Support timestamp parsing in Tx (tx_free_thresh, fast-free
  handling at dev_start and in queue setup when PTP/ieee_1588 is enabled).

- Patch 4: Enable PTP for Thor 2 VFs by creating ptp_cfg when the device
  reports PTP support (BNXT_CHIP_P5_P7), fixing "RX/TX timestamp
  registers not valid" in testpmd ieee1588 fwd mode on VFs.

Ajit Khaparde (3):
  net/bnxt: support handling PTP frames in Rx
  net/bnxt: pass Rx timestamp in mbuf
  net/bnxt: support timestamp parsing in Tx

Mohammad Shuab Siddique (1):
  net/bnxt: add ptp_cfg struct support for Thor 2 VFs

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

 drivers/net/bnxt/bnxt.h        |  4 ++++
 drivers/net/bnxt/bnxt_ethdev.c | 32 ++++++++++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_hwrm.c   |  2 +-
 drivers/net/bnxt/bnxt_rxr.c    | 30 ++++++++++++++++++++++++++----
 drivers/net/bnxt/bnxt_rxr.h    |  9 ++++++++-
 drivers/net/bnxt/bnxt_txq.c    |  6 ++++++
 drivers/net/bnxt/bnxt_txq.h    |  1 +
 7 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.47.3

