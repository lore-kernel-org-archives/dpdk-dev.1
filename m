Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B2CC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 12:27:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7754E400D7;
	Thu, 24 Apr 2025 14:27:29 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id BF1B1400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 14:27:27 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so695802a12.1
 for <dev@dpdk.org>; Thu, 24 Apr 2025 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745497646; x=1746102446; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cG3fRIk3PXsRAm3ZisEMspOrdN5uMX9R9FDxnGmKS24=;
 b=FRIZtL5vbhE3U+ces8vJ75vNL0iS6j+1nKTOiQ1ork/utag4TFrmUjfNLe5r4Ox+KW
 YqTq+w9/GXPC11/J7cozkgljTZDRG2sIWak2WfEk/5/OyiTkDvhHFbtap2xfbpEPM3qH
 qZR9HCvcsmQGPVT0Ra8K+TUiH6my1bQJzIEM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745497646; x=1746102446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cG3fRIk3PXsRAm3ZisEMspOrdN5uMX9R9FDxnGmKS24=;
 b=QxsjrC46YMf3sJ2SeOEe/kXNw0rvWEtKtJZY4vLjzhN1XXY33az8cTVr1WyBZpfaqL
 pZIywsyTbrU4eBMHrKX4NlEg2Al0VAeGMWSYLKxGJVGTel5ZuzFsLdclnpyLIr+x+Roh
 CxNL923uSyYVtubiuxIMHWs9Z01B7RqO6t7ilnn5IFPBzQ702OWJsoodc7PmG2QPIyT9
 sXAF/3Xw3xYiolN+sCjDxryGhHnuzVGzpDdHbdmziRpACXaj8NqUfAcwKL6Goqj02Jh0
 z75BCAoZuZRAid+tdTIH4XQDTQqf5swrFzclArIyYwLEPOdvTdHW1Uy52Tyuo2Izew8i
 3TNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/GaLfwmAxUjLFHrKohMHbNPO255cdAktLjsZl2xWBvnQN2aUr9EjlgBWeauKvpL60gJA=@dpdk.org
X-Gm-Message-State: AOJu0Yzy5ccnyUSTQhy+u2GCZB8Obp6qa1oQzZvJqT7Zrk0IQ24aSafY
 jSKM7yUEnBQwHKbU4PenmkDYeDVEWQmYTYrX2pAcV1TKBTqIUVUc+aIQU+76TKGh4rIeoNTlaRW
 Y/hCxWByETzviKPwxVDvGoEmn4sKlLv7EoToA8Q==
X-Gm-Gg: ASbGncu1QLTl42lQ9MNxfZaP2DRf1MKcv3vYnpwLkJ0PeA9unENHWVuiRYru33F5fIm
 IPIeJErZA5YAkhZfumAyis98n+HHWLL4pdADFI+pUkuzKc2y5FhhaaoRMq27waoZcTPi0DT/u9e
 /yRmpOEXv+5k6rYdM9keGYKnk6TSrgA+IHosZITxb7DPaXZBkJZgP6Lp0=
X-Google-Smtp-Source: AGHT+IG7SPjTZYv2VK7o7bNILTefZ24FT7QUZ/VSYqGnfydpMNw9GZWWNFypnkgfHnCJVNgMjVScJ3juVAG+r0oRF9E=
X-Received: by 2002:a17:90a:d60c:b0:301:1bce:c255 with SMTP id
 98e67ed59e1d1-309ed31af1dmr3319004a91.27.1745497646713; Thu, 24 Apr 2025
 05:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240923154936.15952-1-jspewock@iol.unh.edu>
 <20250220212443.66483-1-dmarx@iol.unh.edu>
 <20250220212443.66483-2-dmarx@iol.unh.edu>
In-Reply-To: <20250220212443.66483-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 08:23:04 -0400
X-Gm-Features: ATxdqUHDQ8Egp061JZov6BBmoMRBp70G4K34kMfkdgZQXd6FqoQeZxcuVfMJK_w
Message-ID: <CAJvnSUDrwuOvg9bd035jiCb7KK-Kzhimd7njF0B9xWPej0ZOJQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dts: add clearing port stats to testpmd shell
To: Dean Marx <dmarx@iol.unh.edu>
Cc: npratte@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org, 
 Jeremy Spewock <jspewock@iol.unh.edu>
Content-Type: multipart/alternative; boundary="00000000000030652206338557db"
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

--00000000000030652206338557db
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>

--00000000000030652206338557db
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;<div>Tested-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div>

--00000000000030652206338557db--
