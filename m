Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C952C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 13:34:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C957140E3A;
	Tue,  8 Apr 2025 15:34:13 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 19F1A40264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 15:34:12 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3031354f134so4168631a91.3
 for <dev@dpdk.org>; Tue, 08 Apr 2025 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744119251;
 x=1744724051; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55NATMYevz3HsDqEtSZ/kRCiE996tkC3HX+j3l+y8Hs=;
 b=pKlJB20XI/ke9feglJXwYMEuuC53N+5ca8ivE4jDlNW3EYXgFboLJFx2+MEZiEPtgA
 AVDKfVssJwH6CRtaDJOreCwTrPSq2s2XvDEHAxBTa7fIwHsNLEYRITs9IET7EQnkex4B
 F4jhmc53/QTlb89O9ezxjR35xVkSujVZZfpKLJKBk77kFSSHT/k9xNQRiXX52RGRlsKz
 +Em+0I604IGVW1q0ZnwtZT7mA8NU2UGScqVeV+DIDdLUFXWf1h0vcWayePujVq5O/dhF
 v6ZDop5Md1WZK/emBeggHPd9cDmwo7dz5/bkJ330KNgFwQm6FomvKRpT9NnPQTkoYxRN
 7IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744119251; x=1744724051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55NATMYevz3HsDqEtSZ/kRCiE996tkC3HX+j3l+y8Hs=;
 b=K8kukK2qfzQhT56dFzS2B/wewzUS0/fOqdBZ5d/yqygl5P6B5njOHwm7P0NA0kqudZ
 f4ht15VclL4KUPhsWCz51cAVI3mpqAKlYqE53TPI84MZJdQ5lbhZSdHGE2oJr9AcU8xc
 UwEC/ITcFm/cf4cZEav3QLtPJM5PIft9YhnVVxCMjdmsg77x9jyCxqoaVazQFaliwLvL
 EaztVfJ24La2I0Lo6Y7DFN1i0h/CXboTcPt/HbbZ1Ak81YSTGd/Rv7CTtHHS0yjZAFLz
 lQqM4kM697Rd+Ah8cvpjJB1IAVJVB0a+lVyY7U07TWcruwwp4eJwzV6N4chb9gZ6/TcV
 OccQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/OAeYCrBJ10S+B/LT+eCtdw+H/KM+OXZRWUG55UugCVwfUB8ZMNjz6iLBbDkI2sm66qI=@dpdk.org
X-Gm-Message-State: AOJu0YwWz0xgaWFuh6GNtHC9YrqQflgfGH8HhcR04lDoKd1EKkj0IcLR
 QAjQyo8NbTQAA8IHYcKrexGOq+ztceehG0bEhlMFmKGaEiphKBtSTgHqEpASD+c=
X-Gm-Gg: ASbGnctN6z/qeCPGg+RN52zdE6/acF0h0YTIkXct3WmiMzrjtaZJNgWgGNwwMQphq4w
 lo40kluq0oGJmVvZ0nDeNyxElSVTspXdMYmvyhJFuwMm8ZXsmNU57Hf8Q7tEqfTp/5jcGm5r3w1
 OaVzc/vn6yhC+9TUXxrsS1LmTAScyB7Yfo6SxSrhx4n3kJVzcAZM+7N+f9xsq0J4ZupN2BO0aMU
 6edB/AoOq+ikryPzNK+rH+zMozcK8mruG4UEp8eThdlQjAGG02C9j2cMFfwIj9XmgVn0SBRKsLv
 MBD4q7Fa3/IGhI4BqfcMg8x0horF/mmSKgO1nMBevqVO6wu88NdhQ4gIS4Xqc4GDKi4B6Yv0yc2
 QD3YOadsIWzt3LGBuEc1yL7v3k6morxE=
X-Google-Smtp-Source: AGHT+IFSDNp9KaMvcsuA59qfOfW8sDQZjf9Uy4qSSUL+b5KUUQ8oHlu1bdv/TE01X40W+yJM6lDe+g==
X-Received: by 2002:a17:90b:574b:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-306a612dee9mr25027854a91.12.1744119251136; 
 Tue, 08 Apr 2025 06:34:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-305840b460asm10957733a91.11.2025.04.08.06.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 06:34:10 -0700 (PDT)
Date: Tue, 8 Apr 2025 06:34:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v6 14/14] net/zxdh: optimize msg processing ops and
 modify some issues
Message-ID: <20250408063408.7f13512f@hermes.local>
In-Reply-To: <20250321073200.2015711-15-chen.bingbin@zte.com.cn>
References: <20250319085808.1912523-1-chen.bingbin@zte.com.cn>
 <20250321073200.2015711-1-chen.bingbin@zte.com.cn>
 <20250321073200.2015711-15-chen.bingbin@zte.com.cn>
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

On Fri, 21 Mar 2025 15:32:00 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +
> +#define BUILD_BUG_ON(condition) do { \
> +	if (condition) \
> +		__builtin_unreachable(); \
> +	} while (0)
> +

This should be using static_assert() please send a follow up patch.
