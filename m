Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D44D1D478
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 16:12:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E137406B4;
	Thu,  8 Jan 2026 17:12:38 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 8FDE04027A
 for <dev@dpdk.org>; Thu,  8 Jan 2026 17:12:36 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so28174005e9.2
 for <dev@dpdk.org>; Thu, 08 Jan 2026 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767888756;
 x=1768493556; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7ph+K1d341/x1rr2GIxp9tTSyuFLvLnaldfECQiD6Y=;
 b=uR5XWDwzMcElAJM102kk05AvX/Th82r8wgEl9fwM0POanR19ZjTBBqJHAv6gIE+UDI
 8YCemgPHvooNOHHZCvNedZ2t6sVuLu0J5Rr19dxN8e4GntZLBckNmICVpFUUxHdzkoXy
 VxH5Vn1uC4+Fvxlm55BrEjx6XD79U3dlDJ7aW27PV3gc6xQUsFhKFhM+yM9lFmLEf/M9
 AHRtuKD23GCV+HzhphD9nbFNYlGB+08MReC/HYkk5RCnKK5b0VCUAisyTe+p3KN84qxt
 mJqw4nlm10MVpHnoJG+LKNeqeiRdPwLLtDqepEEA5OS/979PZGZYNm0Kx8DpFwBY50FT
 Xhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888756; x=1768493556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M7ph+K1d341/x1rr2GIxp9tTSyuFLvLnaldfECQiD6Y=;
 b=PzFiWMedPXfbealqv9Lz0Qse4e3qO8wwz/cOQhUD56E51Yuwp0o0/EXSR2BvbDOfbP
 jV/ZPAF36YN4fIJl7zH7140pYPB2ZU1rebvtRFTBrpMTtcBRjBwhhIlE8hc2xJaxS7wD
 zKVwh5LMkvdDJAn3svbK0clNQ3XaHfxfz/H+nhkg3ELVWPSrqnv8/9w0BG5IXGA8gncV
 JEr2N57BiIKKsVenWOgaFLM4XJOIDLAijK8voskV24u8PJYxuSkzWddlLHfGBa07ZjfM
 9r3wEASREkmYYEN7apjCW1qmEcI3C8Tt2n9bk9CsjZ9QnrHcnMcyKuo1uCJxyCEPSNGn
 qxPw==
X-Gm-Message-State: AOJu0YyKPrPhzPbc4+dpRX9a0iLinYYr+cueOQ3mEb8zWqMLaqpI+FUQ
 85uUUIuImu1rCXXUNCK7qlcbklvs8OxpHJCut/C1zeMXEKzrUwesSZ20EN9tpXZCcTc=
X-Gm-Gg: AY/fxX4qLme2AHCU68M4/+YrX9AhQYaiae0GW0PVF771Vf9hayKHl059/2eYE9y2j7l
 srjlc5e9safoeKZ6XDvIPiTFoc6YtC+orub2dOufnicfR1J+g2IT1xcpHHnrqRuiaRVjQoAuWs6
 oQHQTZTl0X/Mxk+JgWu5P7AtuzRplq22qicR6eHg0EXp/WlVPRyH/ExvyPfNgReNsM+EBvex/ev
 e20JWH5TDRUUngDu1uT1ar9nkjxTlkvVLo8bifBSRGHCRPEaMB5ZaxkNwc9Ld+F5jTjIT9iFFBi
 8JH48xp+W410gLcmfN8G/p7jtVi3/XV6SK40LsEMnVAeXhbTf3RkyTQ7YWSIaHO+Soavh4tqR0M
 sdw1e6024zHYJctr8r7tUGccB9tR332GrD+lSKEh+SQGjWWNEkvzaQDgFYGZ5+tIR4xjqNj5VzQ
 CKjcUkyOsTHiBGfYdJUSzWf40IfhK58S3SlhFsTgaVpa1//ae64kx+
X-Google-Smtp-Source: AGHT+IGWdsvwqNku3myuBA1l1ZAjIRr59/DwYZEk3NAMef2ELRHSleJuL/V2iLlwSJu5s11l6/Cvcw==
X-Received: by 2002:a05:600c:a106:b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-47d84b3badfmr80661925e9.24.1767888754761; 
 Thu, 08 Jan 2026 08:12:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d86641e99sm40408875e9.7.2026.01.08.08.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 08:12:34 -0800 (PST)
Date: Thu, 8 Jan 2026 08:12:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v5] net: optimize raw checksum computation
Message-ID: <20260108081229.60b095b9@phoenix.local>
In-Reply-To: <20260108061338.27217-1-scott.k.mitch1@gmail.com>
References: <20260108061338.27217-1-scott.k.mitch1@gmail.com>
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

On Thu,  8 Jan 2026 01:13:38 -0500
scott.k.mitch1@gmail.com wrote:

> +#ifdef RTE_CC_GCC
> +	/* Suppress GCC -Wmaybe-uninitialized false positive. No assembly/runtime impacts. */
> +	asm volatile("" : "+m" (psd_hdr));
> +#endif
>  

Maybe rte_compiler_barrier() will do same thing?
