Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFADBC43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:04:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A50B240264;
	Tue,  7 Jul 2026 10:04:42 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8A5334025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 10:04:41 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cad225673bso31172055ad.3
 for <dev@dpdk.org>; Tue, 07 Jul 2026 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783411480; x=1784016280; darn=dpdk.org;
 h=mime-version:content-transfer-encoding:content-type:msip_labels
 :content-language:accept-language:reply-to:message-id:date
 :thread-index:thread-topic:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8bqVdrV/YAXGlR3Tn9LRGEwcHFxHm7ze28fm5wEM3aI=;
 b=jaNYJ9Ua+LfPNsldaWP/M7TvTvwR09Wh2iyj4hwT3tF0SddAxPwUzilfOL3ilL3+sn
 imIZ3rwoWMq3/54s5lFkMokPidcn4TPPjXVwk3ybEsI17/Ti/wNfY+4l5bV+wHaI8BR2
 Wwcxy8HkPWlyuQ6dwwI7/dCcYgstJCWf+kI0xayE8NO73OJ95uTrdddOU9Hd5gM0riGk
 Q1BT9spmCet0avEOdnNj3y6AEYXgPtkFhQv/L3JU+v4jd+KHQRmiumFdmu5n2FP7sbqR
 Obe6D1oegHG/AFwg2dZqistWV6XzyYLbd+l1qNzr3QW+CJwm2oF0ab9NOEhgDwcULony
 97/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783411480; x=1784016280;
 h=mime-version:content-transfer-encoding:content-type:msip_labels
 :content-language:accept-language:reply-to:message-id:date
 :thread-index:thread-topic:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8bqVdrV/YAXGlR3Tn9LRGEwcHFxHm7ze28fm5wEM3aI=;
 b=eqTcvSN3bJBITwMP6TM0+GblAxUI1yWcTVMj+tqLAWjgq7gszD2RXodbSq4bsyv77H
 rMsw1m6w5uGHCAQzcjvy8+GL9oI/ecvE0LJK8lw0gDqxDi24k9QYFBV/521tqvZkEnF8
 ZbDOICLRMLHMX1vXQHvbtdbhK3zcJDi9Tl5iaZpDGnabHfjMLgd2KjYr1/C+N91Mn4jf
 vsgXdl1XmBMJAafhT0j8u5xQdHgwKM5lTgljm+uMKi4QgZqyunJ/vQjtLMBSEBbDG/7D
 m9t3Bt14gmcChyLA725sUVYWevnj4QROfBoDJbxSYyqjmMkFUGcltTh4kgjPrYAFQtTN
 H7MQ==
X-Gm-Message-State: AOJu0YzBlNSVYK3Jk/eHyyjfJlVI1ogVexHt4OowaZk90XRxlkiZMdvm
 brM31tuCNzMJj7DDoOV1ebn1UPivw776bd4RjH7EFmcMNeEvSIiY9Cbg
X-Gm-Gg: AfdE7cnr3WsxofsM/IFr8U21CWlc8h5jSHpPYOE5988Pc1ATSqbnqqKcunMY97rsI45
 IkIjHiB/F5qPT5CR9Sa5v8PHDy2oFSRgjeZ84t/+/+9UfdEceyiEkjfgdj0ZNUjBPVZd7Wmc2H9
 Ol6gsW3LAaCivRkkUwC4sFOP8D1eEmh7hDokv45eFX8PqTcSfgrr0TH9j3Kb1I5Q2u5z4rG8a5z
 Z6VnAHJDDIm7F14SoKBMDJv36zj2rOVTn1tZt5qP15IPzo4urZNEklq4qlESKR3cX6UP1vPVMwc
 PBusJHVK82ddH57j1zglu1CiQjB8qQTzThXU83TbTgkAErnqg3r07MUg99GqwiQQ4C1lljvP77m
 EqjbciL0S6TZxzOFc0sjVr8IrK5lnAyZ9swWmrVCr1dsk0vyxaZmN1Dczcc94ZkztK8Up1lIF5B
 9fL/Q+xa6gvagrXlxCbEO8yjDdmdMfXKaQySUnPEH2xpzvG7vtoAHU7Wz+QCJKsz/68ina8mVoV
 Az9m5gmI7r63KWdtAHWXhx1hVHSRdyLu8MRvcF2IMHQKWXC8xsb
X-Received: by 2002:a17:903:38cf:b0:2c9:e9c4:82c1 with SMTP id
 d9443c01a7336-2ccbf051685mr48947835ad.26.1783411480361; 
 Tue, 07 Jul 2026 01:04:40 -0700 (PDT)
Received: from EAYPR13MB731689.namprd13.prod.outlook.com
 ([2603:1036:308:4c31:365:be:0:2b]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3d2efsm7200585ad.64.2026.07.07.01.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:04:39 -0700 (PDT)
From: Simakov Aleksey <bigalex934@gmail.com>
To: "kishore.padmanabha@broadcom.com" <kishore.padmanabha@broadcom.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "ajit.khaparde@broadcom.com"
 <ajit.khaparde@broadcom.com>, "stable@dpdk.org" <stable@dpdk.org>,
 "denserg.edu@gmail.com" <denserg.edu@gmail.com>
Subject: Inquiry about status of accepted patch net/bnxt/tf_core: fix null
 deref on pool use allocation
Thread-Topic: Inquiry about status of accepted patch net/bnxt/tf_core: fix
 null deref on pool use allocation
Thread-Index: AQHdDeXmGwD/g/OT80OkgFn1GlXjgQ==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 7 Jul 2026 08:04:38 +0000
Message-ID: <EAYPR13MB7316899D71B96849EDFB8BC0B4F2F02@EAYPR13MB731689.namprd13.prod.outlook.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
Reply-To: "20260603041557.115956-1-denserg.edu@gmail.com"
 <20260603041557.115956-1-denserg.edu@gmail.com>
Errors-To: dev-bounces@dpdk.org

Hello!=0A=
=0A=
I hope this message finds you well.=0A=
=0A=
I am writing to inquire about the status of patch https://patches.dpdk.org/=
project/dpdk/patch/20260603041557.115956-1-denserg.edu@gmail.com/=0A=
It was marked as "Accepted" in Patchwork over a month ago, but I noticed th=
at it has not yet been merged into any of the DPDK branches.=0A=
=0A=
Could you please clarify the current status of this patch?=0A=
=0A=
Thank you for your time=
