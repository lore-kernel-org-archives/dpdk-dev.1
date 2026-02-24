Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF7F3C9B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 16:30:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4873440270;
	Tue, 24 Feb 2026 17:30:22 +0100 (CET)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 683B7400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 17:30:20 +0100 (CET)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2baab3137bcso4875946eec.0
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771950619;
 x=1772555419; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAoLVD+LE/4XN08+BB+2zF5s7Fwb5OhOTHD19YZzYck=;
 b=DVaPlTgTuOoM9rR/t2PpoYfiBaM8uJIWMIlSGexvDnWiNVn2O7ybLY9E5BpU7+9wAL
 xuyIentYeIuo8Sl+lp6m/xBwb/J48/WWTTh12qFp5hUIn3IT0KiDR4bhehJltagGGeKN
 P471TN6ahiNHAYC/vjLleseSSUefhhV4kCwJPvW/5d183iHqDaZhbTr7xpalHdQEMtnK
 +7LiRDJREaXAI7ratHLnOx0/Dgu4s3lTlRyYfHe504w3oK0RT70QDfvCvzB4cRAgZuxL
 Itz3dLtMWBRg1lTvBal4lGkSkxzjwrzG/YzwemD/HXYHqbKRi5d3kvNWAtSDKWhNhJhy
 L9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771950619; x=1772555419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KAoLVD+LE/4XN08+BB+2zF5s7Fwb5OhOTHD19YZzYck=;
 b=SUop9FsBGCbJXjI1YLoEO9OtcrPrsmSmQyAzd6K5lOKfNKoKBAyC7yaZ8I48MKW9Y/
 eIi8o0iaMgvX+DSMMQa+q+Qp+GorxjDpu6zM+zSspwOjROZ/GZPoVjxLCWgJxKWCa+Dm
 Wx32VnfJehVZNAs5WuGCtrf29p7jd2ckJ/GuEYBUHyjCDP0KFv0T11/+PuPgm4iu/bhy
 VrRPDwxOIOP6Giz8y83yJSzpZBgCGCukFvKPiDsEA2z/J9nBa1mVAAgvrSE6QnAwNUqa
 wuPAzn5EkeNNm1joaKM+CCcLeHi79eczUkPP3tQvF66/ocEu7hL3sCyxQLBVrteGz5ve
 QOxA==
X-Gm-Message-State: AOJu0Yx8Gt82w2HiiSlgxJl2X8c7OQok5ycDqMdl7cbRFHgfFNR+/yIb
 Vreruv12sdCOHPdcyz2Sw21hpi+533eVWokME/TWj8+yHg5eJ+MUm5k6SrmU+aaSVj8IxFXeA3x
 jR92K
X-Gm-Gg: ATEYQzw2tcXlo8hY3B7CVAxR8xH0Gj9Z3Y4dNkmy4HHytfULnm3NirSZlNZO/+crkBZ
 gV3XJoMOXMhUSH8+cVXriCx6uXwtqo0u1ba7i4cWWqI2Mfv+uLA1Fk0kjb/iOlJ8uPwtJzzuohb
 +Ln5y73ekXODcuCBESouHpgnCLoOB5ni2edcFH46zSOsYTihbXBAz3Yq5aVniGBHsWa3GkCIyMp
 QXUNZiweY8CLrV+Y5WSAx6M9ZEAau2ewDaeFcSc3I5pZ5YLk/Cnc3cEuANFVFEnZEVc60hN+1F6
 xp/VJdXSuK4hW/c0DfqB2D+KOEMHzLaMDFQNo5Xihk8Xqk1IP1+GCTI2lFyrmMl6BQuSIIHwyJF
 TlsKrj/TKmgJjPRFr6UQQQ+CE+OSnf8JFe4/+IzIK4j3nF65gsQg3w0pOze2SEr7s9oqrWVw7v0
 Fv1qrB3JBToR76BgLLpMLCYj443hQvPZov65Y+tGlBae+DUmssH9b3bhOnYlIndff0exV7/sC6L
 E8=
X-Received: by 2002:a05:7300:dc83:b0:2ba:64c6:2cd7 with SMTP id
 5a478bee46e88-2bd7bd2a1c7mr5556460eec.32.1771950618845; 
 Tue, 24 Feb 2026 08:30:18 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af9f74bsm9427085c88.15.2026.02.24.08.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:30:18 -0800 (PST)
Date: Tue, 24 Feb 2026 08:30:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mingjin Ye <mingjinx.ye@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v4] test: fix option devices
Message-ID: <20260224083016.2c07ba44@phoenix.local>
In-Reply-To: <20241016081719.1619975-1-mingjinx.ye@intel.com>
References: <20241014100026.1517769-1-mingjinx.ye@intel.com>
 <20241016081719.1619975-1-mingjinx.ye@intel.com>
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

On Wed, 16 Oct 2024 08:17:19 +0000
Mingjin Ye <mingjinx.ye@intel.com> wrote:

> +		for (i = 0; i < numargs; i++) {
> +			if (strcmp(argv[i], "-b") == 0 ||
> +			    strcmp(argv[i], "--block") == 0)
> +				block_num++;
> +			if (strcmp(argv[i], "-a") == 0 ||
> +			    strcmp(argv[i], "--allow") == 0)
> +				allow_num++;
> +		}

The long options format allows the equals form, but this doesn't.

The argv scan for -a/-b/--allow/--block uses exact strcmp, so it won't
detect the --allow=DEVICE or --block=DEVICE joined form. If callers use
the = form, the parent's device list will be duplicated in the child's
arguments. Consider adding strncmp checks for the PREFIX_ALLOW and
PREFIX_BLOCK prefixes or use getopt_long to scan.

This is not a huge issue, but could you change and resubmit.
