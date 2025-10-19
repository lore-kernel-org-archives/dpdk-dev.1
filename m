Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765C1CCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 17:00:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C03DF42D83;
	Sun, 19 Oct 2025 19:00:44 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 6B5AF427B4
 for <dev@dpdk.org>; Sun, 19 Oct 2025 19:00:43 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7841da939deso3308084b3a.2
 for <dev@dpdk.org>; Sun, 19 Oct 2025 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760893242;
 x=1761498042; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P2gPhqZ6Z46Cd6SQe9/0QqEfW1rHIpQdbguzN3J4pKw=;
 b=AyTUWaX4+qOgruJh/fv6ETP71jQ+DhH83ZxDbvisNnHGc9WqneerAL6g/bHZAmEVTd
 igRE53WG6J4fz1Db3R9Vw0PjZGmGuwWXssR/2tV937I0EXi7SEqUZeaV/PjXgoHLI8M2
 rRgHT7tLbzAYAXDCn/7awKFBRNXksjwfg+HNIS/dOY0Za9fHY2s0C4j19zRXLXIvbfyd
 ZWbe7mJGIilHXLl+DTqapGqwtumkeOvoC3O2MNUu+1eW+GRr/rzOjz52dTW3ivIpEvfh
 L8KmtfzBFC4S2SjVk1qrtgsNC6aVDsCXmV6NOD0qyHT+o853PStG5w7pQ3gxDL2EQmhn
 sLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760893242; x=1761498042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P2gPhqZ6Z46Cd6SQe9/0QqEfW1rHIpQdbguzN3J4pKw=;
 b=NHBXYo/h4KgSwbQspT0CtwVMjUfAksVmR3qJrvsgEaln57RgSw/5wysAt11fjTuL1J
 ktkTSM2mDtFCScjEXlXP0NJRf/urbQHbINMOGY+JDf0/YGRpPVR0JR5YAkOrtzQ9U0z9
 dXvl4FjFkp8cxGIeEXfK1JBGsc59WT/NqnbVEtCKKlokA+xrn92j0iP2D9fZhfZXvlOt
 kaOcTvWjULOuvNR+bCOnnoKM5H+IDpwwztogKxeHprf89CZnnHpjLITMpzzXIRJw8qFp
 PiQtvhy76EQ8Ef4LnHw4RnvFvz60KTlLxJrb4UbjqjAG2OE3ugTUFN7/jy7e7okvKE0A
 VVcw==
X-Gm-Message-State: AOJu0YycsL8VHihzfb+p7KdHMkmInfrVY/tzTNf8qnsl+v3l00d436Ay
 GcMkWmn1g/PaEEjHeVxDKaemWr0jLwpf4DxQK6H08hceA19x/pm4a6jJAkCW2Dew2Kq6gS3Wzr2
 oCkmGO5I=
X-Gm-Gg: ASbGncth+oeWirIhGcckUu+RVjhYC4gEd3Mg870yRq0dIrnngM2xvADw8pCSgotytRf
 ZIfK2Iaha/rmACyHcXeSHAAKRkur894Qja/WQgEnscQ4oIgojpsj/9GR+NnuyQmOJiN7ldzMKou
 JOFTStcqzeydLoPqIshPjBXEC3/botENTj1m07NUr3dhDJw0LtnlMgB+qssW1vM9TNj+rZnjFx5
 OhQX6Ujp1Kh1PCoiYY942F5oyZt7MRcaarFXwja5TO/eFNvgJ1bGGSalwdKeY831+dx0GdU97Gi
 rDHUY46KVi+P1/s2qMdhOO2JBRcuJ0ecLVqdKyN30CgF2dM2gm0ViR7EaPl1QUPB9N4vyB43+Q8
 FdQY1zCcY/Az1U0WAln1UNX7htSNz0isBFSdcTCSS7e0sPqcXnflb6VBCMBCFDQIXch2eEvNGwH
 Fbe2KPKS8nSELVmfJPzNhm3Mn6uQQZgFZdMo+v+Wg=
X-Google-Smtp-Source: AGHT+IF+YvsM1OYdStA0v6IJ5H1q1dn8nnJ7vA9Xab3GSWlTNc30R6woJ04/EmYoWNdmIVqoVr1obQ==
X-Received: by 2002:a17:90b:2ec7:b0:32d:d4fa:4c3 with SMTP id
 98e67ed59e1d1-33bcf90f957mr12107333a91.31.1760893242434; 
 Sun, 19 Oct 2025 10:00:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5d00c909sm5696079a91.0.2025.10.19.10.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 10:00:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] minor bpf improvements
Date: Sun, 19 Oct 2025 09:59:45 -0700
Message-ID: <20251019170040.166372-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Minor update to BPF. Add allocation annotation and remove VLA.

Stephen Hemminger (2):
  bpf: add allocation annotations to functions
  bpf: remove dependency on vla

 lib/bpf/bpf_pkt.c   | 16 +++++++++-------
 lib/bpf/meson.build |  2 --
 lib/bpf/rte_bpf.h   | 11 ++++++++---
 3 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.51.0

