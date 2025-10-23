Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E871CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:52:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EAD4402A1;
	Thu, 23 Oct 2025 18:52:41 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id BC19040276
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:52:39 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7a26b04bfc8so1205311b3a.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761238359;
 x=1761843159; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEI59BNWRRXbZbRvticbyO5T7uXEQaThNuUbdTm1+QQ=;
 b=DCHyq384fVtLJ6+fWUJdKSpGnVdindcq8LxsUxTzwOIioCaIk66FMZnK6UNGyhyjhC
 qvHUTaH/OXPqJWlMQQWx8y0AkqA2CDJzZRsB5cS1htgyeTSGJ3N9pjMcAgYgslymfZMI
 ZbodhgLO0i/Pk1V7bq5docQ9Tt2cYVGSnVpFX62xbb1rPo6ymVlm/yl+zEXM9F02vOIe
 GQKUBiC1n69mW6Piu4RFtRybGICCrcAPEcr5HeAUs14h3QjGtI7zZARFm/XJwb8FPHOI
 53Jn3BCjAatmIcZ0uAZYQ0sX7cvydd+Cg6Bk35ach/6LZN02aAdV0q3B5kBOy9swN1r4
 5meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761238359; x=1761843159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEI59BNWRRXbZbRvticbyO5T7uXEQaThNuUbdTm1+QQ=;
 b=aEds5zPjIg1RCj/CtCYY/XkPdAPSMePLQX2rYeiZ8yn6l1Bz6TJBLIGGJM/+GlParo
 uoDlRKTwizT9sCf9l8QZNraWfgffxnVczdNFuo0BK3zwqWqBIr7nj84xX2+AzGGF5r70
 6AjO2jkl0DWcmKVj+S/GMD5vK75BpMvWt7edNZkfC7Z5jzDN4Gb/+6Vu9jny67QgXwOg
 HuJULjJr+jSoUSelm+Aa2SS0uUI5lP0UVqgITadfh5aWxh+apmVPJ809EzUVLotok5Yp
 8Dv6HzMe8LAtzZ9hYcCz7iMCA9mUl9n6gxd1/uPvWBwqG/rkf4tl7aNLf25f/c0ZDcpE
 O24Q==
X-Gm-Message-State: AOJu0YwURmj8Qftgbke7xROErMDF0egRHDwdZK9eYDCnYko3LUZI4nik
 0/kFV0UqZxONtXT7JCRoBXSw9IytHqZ+miHnOPKJRgU37FfenJbaUIVzdXSaJ/BcoSYGOkDf/80
 wvR0y8C4=
X-Gm-Gg: ASbGncumQloOhPpI2zq4P0bvBOfIMl2jzQc3CLLTPjSaihRBR8oQO3dA17KlTnwIT1W
 mM58RLSD9wwNib0dqmHZFt6FJkXftF80wWm4KyDgJGQ9cYE398is3f+YKfIO1VUxQgfM8g2H8SP
 pymvowk0fmrykCiK00qrU+uTpz9nGJssNJZ+G8WBUxX2EeW7CAPIJuv69FKcPM+KEjZkT/NsMjA
 VKxDQ9aYOKfE72TrrN6Rwz6q33p55wQ89c/OcMliN2XgPylVkgx8vtgaWO+76ckW1hMAx8VEoKE
 nbLQkC/TodsqaSkrvDqTe0hA1xzBm3+FKF/zjmEq3dTmFEuiHo4lR9P7Ut6JbDTIpKOsJRqUAoP
 hKxya6hwQe96oNyVwKpz+R1ikJ2bGwCdyvR7Nl2l7if7G/lEeF4LZepCx9NVm4rr86YSz3wGwf0
 uPyKRnRhvGLvLglgRkePh1v/cAcmgv+WUsyh4MF0w1/yg=
X-Google-Smtp-Source: AGHT+IHILglp1vOe2ABxCBTlZfzheo9JodIT7+ROFz+ATmr6Aph5btlel6JfcEedpoq9GUrTMqbqNQ==
X-Received: by 2002:a17:903:4405:b0:27e:ec72:f50 with SMTP id
 d9443c01a7336-290cba419bemr247319025ad.51.1761238358833; 
 Thu, 23 Oct 2025 09:52:38 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33dff471851sm3716720a91.14.2025.10.23.09.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 09:52:38 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:52:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/ngbe: support to identify centec sk21101 PHY
Message-ID: <20251023095236.6b1bcda8@phoenix>
In-Reply-To: <4BC1A3490B167701+20251023033207.62299-1-jiawenwu@trustnetic.com>
References: <4BC1A3490B167701+20251023033207.62299-1-jiawenwu@trustnetic.com>
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

On Thu, 23 Oct 2025 11:32:07 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> Add centec sk21101 PHY ID into the list of identifiable PHY IDs.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Queued to next-net
