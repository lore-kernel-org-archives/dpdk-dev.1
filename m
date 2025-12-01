Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DB7D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 15:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AD3240268;
	Mon,  1 Dec 2025 16:59:49 +0100 (CET)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id A35174021F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 16:59:47 +0100 (CET)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7b86e0d9615so5232927b3a.0
 for <dev@dpdk.org>; Mon, 01 Dec 2025 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1764604787; x=1765209587; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AZONNdwiwUJg0NblLm7uz5WXIe2PA2s87yrobBNZse0=;
 b=CHD7Lp0MhnB2RlTQzSOxfeTxNV2ZQhBDeXem3eL2Hjlxm3VZc64h04woOEbIwmCZ+6
 wv6G2JQB4VGD5zL7uj7HSfmVLqEr+bqff3vZtcb7XY8M0vqdOb1bFj/1Srwu5pyDKpcL
 Pys5VXWlBOLB/oR9VyejqA/VXg70Rga0eyjlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764604787; x=1765209587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZONNdwiwUJg0NblLm7uz5WXIe2PA2s87yrobBNZse0=;
 b=vDa5H46HXDT8enujEzBOhMbxAPqjsKsTawbXkyUDqzSg5x7VswN9tAH9/ODn4AmQKl
 uAhYctPBg1U8sJTa0GJErSHG0aRN9NMwSm8NKR8QhBZtaYJrM1AuRjPmSOpIFkqipcA7
 oaMALvj7l5UVYkRifMBfrVoJiJBlzmPcfY7hiB/GpsOn9VE5WlqbjSyikcqepPRi/9mN
 aaswzfL7tHtdGmYBi+zhZk7XwH4A8Aodtsd3QOZhjkDf2YMHX7wDwcBNY80oZSzaB/Co
 OPTmWI8QWISYSNTZl3rQXjUrXBy16/RgTeqCq+Gh/SDJzgnwGgrPZXg9lgporsUNnjh2
 YVLQ==
X-Gm-Message-State: AOJu0YxDc2PLu9H/a2W8aDEKA35/ZjKPMpNal3D/qPQMQG2P/IeamOkm
 ZnJswazTfZ9hGgInW5WLQXr8lpVaMTx4lg4kzczCVOr4jfl9YOAmyANi0Z5iioND+DHo6JAVu/g
 eEElhQ49H3yVu0DcX05par7f9PVXYn6S2ktik4AFH7g==
X-Gm-Gg: ASbGncvlbEJZTX82BQPDGxfCrIN7jcjohjtb2S8Ub2MI571n6PHbA8K1x+w7ywejucM
 0m/BJkH1JFF7hzIZCbhlJ1KxLq/QYaJVoF9UBC8IKfMbV7oDkRs6Om+96nbXYLW8FgxaFxGcLDH
 rjqDDUzDl+svI4XhixU/Pcasqnea95dBovfirBAKDtusKUvqpWfaUTl6eHntSnMe7eJSGhpefLE
 pBXueKGP1N898uR84orcODPBpgpqs5sqG2jyfpT/jDcjX2bNoUm7fjSfRS1cf3Cd6kchnb/gEVC
 RxFhBVn2udl2kn301K3nwV4rwvoX
X-Google-Smtp-Source: AGHT+IEzrPD+2p2oheSqttklsNgy/bOJAksL5FqvlgLPiHf6oMODnXVmkDDCUqDOsCKPb0NlkB93/LJZCNA/i0fVAsI=
X-Received: by 2002:a05:7022:90d:b0:11a:547b:9b9f with SMTP id
 a92af1059eb24-11c9d864be9mr25156666c88.37.1764604786625; Mon, 01 Dec 2025
 07:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20251201100837.422764-1-anurag.mandal@intel.com>
In-Reply-To: <20251201100837.422764-1-anurag.mandal@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 1 Dec 2025 10:58:14 -0500
X-Gm-Features: AWmQ_bk7gIV-PDHpEGEPsyegZ0IH2aryW90c9HhRUGT4HROB9EasdI7K2ybNmbY
Message-ID: <CAJvnSUDh7wL3JXC2e6jUqRkD-7Tz_LiMHi=wT8i=DPgg7m1iaA@mail.gmail.com>
Subject: Re: [PATCH] app/testpmd: fix incorrect function names in logs
To: Anurag Mandal <anurag.mandal@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com, 
 stephen@networkplumber.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000079ddf00644e611e8"
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

--00000000000079ddf00644e611e8
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

Putting in a retest due to an infra fail at UNH.

--00000000000079ddf00644e611e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Performance<div><br></div>=
<div>Putting in a retest due to an infra fail at UNH.</div></div>

--00000000000079ddf00644e611e8--
