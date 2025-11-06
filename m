Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFA9CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:51:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48FF4402B0;
	Thu,  6 Nov 2025 16:51:26 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 43E334013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 16:51:25 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so16595075ad.0
 for <dev@dpdk.org>; Thu, 06 Nov 2025 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762444284;
 x=1763049084; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kv/y79xM8ZblKebXT7AOuy2alOnfFEI8UPsJ9cEeLQ=;
 b=yXC9aKfij6Tlitrf8/PUwvTT047rMYRSbyNC3J1F4pM7FqcHjaUCfwsW1EQ5guQrlL
 7fG9SRCPrO4z/UiZfceoYkL9dGK+EViEmjFaWgu3hGwklpI9dmV3ivQAOGKtjEWHVIpg
 oLlrzHItfu2rOHERnu5CV3J4MebxEBQD5lOsL/1sS5gTdgpzHx8c7zF8cSJbzZNJ0IFw
 Z6ghiFJ2Bqg2BcQue2llJr/ldfLSDvAM1//YkHKkQPypuVPlOwCMm88XMIbqtq5rJ+a3
 zrqptGzsu57IAWCeRf9SPoWrw/m64Y9JLRQN+VByXts+vwmKzL4IAOdUiROd3WIm+ZRo
 hP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762444284; x=1763049084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kv/y79xM8ZblKebXT7AOuy2alOnfFEI8UPsJ9cEeLQ=;
 b=l32QS9KxIkNu9PVv/9Nh0u+HQP38QM07+xANkuhNuB1ftMLq18Mckrj5w53tPuAoJH
 wiy7Qf75trkEQ9mMBS4vKYw0nxo7yAfUzrBHdXaZAAOJBtrJWfCajEdA2wKsEzO+F/MU
 ZrfzWXuPbD5viHWBOKYxkCKBESxSxOB8HusW1+uMOI9ZOuJRP5hQH8kbwyuzXoYG3Um8
 c7L4LZ4RjhGlOwn6IQDyQc4vS68XDY8Uo0wZ/jbuFUoK7t1TBZdFIGT+xCqBKv4lcQKl
 MU6zVhQsZUnpqK9c4RQWo0pwBnTzyluoau6GmvjGHOq0QRXlDWyoBZy25oyyzQGPkhgk
 HSzw==
X-Gm-Message-State: AOJu0Yxg92ZjlFLsk8BK3XudlcERuC61G8QK5F0vRoEEMgHvPNRNx2rh
 0bEe3ii3e0Bv9+qU/7uFvEZOAo2GIwiaj9aBhTbuCMlTeC2+f/SZXduHkFGgkEXN/cJVfyKbuWn
 Xlt+h
X-Gm-Gg: ASbGnctyQ/fe/gpchkB8+QM1A5pOCcCwDRNFwDinrM3lovMgEIgwPOuPPHlGktkeJ5y
 1ES46GXRsB9yHM35j4o1EjwDXJDHNhU7eN5dOj8uzJGFkrO0MQEFKZjuPgfWbKgjnWrVUMh3S9P
 lRmy63J/wVBNexLLwf8OE7UbGlIuaD/lm7uLSnYti2g49hvLzwmfeX7R4ZTZGv3VEUv48c/BwMW
 tjTOpzx81KudHR63X8H6+fxdiy+stcGvSwD3eDi3QQ24pn7Sd5KRkguQYVULPryfsTVCCUzXWPI
 IZ/QFND4mcBJTrRMLNwrHzaae0JZg2vWEWgcUXhXUjOm6VdzRVXKrdUOt2WGrfQR6D+GGPQAJ0j
 pUajDTJxZhksC+UNhgfGA1c+GByA2z4YYXTQWGJISCgtQKj0CcHlH2251NAIOgQF/wISSiUOEmJ
 qyd+GvIKjZ0ZXMYlyIvSuYAPEvZW2q+4X+JGJChC8pW3jO
X-Google-Smtp-Source: AGHT+IGdEzKLY3hTuw3RWzGYBJ4agutGg3PB9XFKgnv2ipd072/H6/1xmw/kDqmGuYNXZWJSvo96jw==
X-Received: by 2002:a17:903:41cd:b0:292:39b4:e785 with SMTP id
 d9443c01a7336-2962ad3e9dbmr116661535ad.26.1762444284439; 
 Thu, 06 Nov 2025 07:51:24 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2965096b8f4sm32551945ad.10.2025.11.06.07.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 07:51:24 -0800 (PST)
Date: Thu, 6 Nov 2025 07:51:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [RFC PATCH 09/19] pcapng: rename variable to fix shadowing
Message-ID: <20251106075120.3a86d317@phoenix>
In-Reply-To: <20251106140948.2894678-10-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251106140948.2894678-10-bruce.richardson@intel.com>
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

On Thu,  6 Nov 2025 14:09:38 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The "len" variable is shadowed within a function, so rename inner use to
> the more descriptive "filter_len" to fix the issue.
> 
> Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
