Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3254FED3F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 16:58:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5270F402BC;
	Fri, 24 Apr 2026 18:58:32 +0200 (CEST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44]) by mails.dpdk.org (Postfix) with ESMTP id 9B93C402A0
 for <dev@dpdk.org>; Fri, 24 Apr 2026 18:58:30 +0200 (CEST)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5a3af1b7549so10116071e87.1
 for <dev@dpdk.org>; Fri, 24 Apr 2026 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777049910; x=1777654710; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZFIznWrASgKWTQqnehMwwDcRWSD1siYePf48E+H27QU=;
 b=fBGDNB9nSKEtMq/2M+PvQkifUyjva30O00EMxDb0PKop/AawmNMtoVM8UY9w+zWyPO
 fDnSInwz6VY/bbW8PjnOwIPoFby/wUTt/ittyHNQMPR7Q5Ypc6Ih19L24tHydjDNYq01
 MOb334T2ZDm14caWJTeNsvTsSLYzCtshe4pJM7/dGCYCPkbjjYkQzhL66NyZiY25QZlo
 U8N8kl8zDx9mbtwZxsDEYOP9hj/zwi0AKYaXkrUHJinn7o9tf9zytTJWt3ODRCIbbNOy
 fuegEjC5udO3AbpiwAbybRuyKjlx7dLT4g0aR95ctidb6HlUmMFfZ7i115KHJ2i6aGCM
 WR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777049910; x=1777654710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZFIznWrASgKWTQqnehMwwDcRWSD1siYePf48E+H27QU=;
 b=FM9QAgJ3txZilwqylF0g9ZKXFu1I6u3D/ahBxOoXc4v/0N9XECIP2CyPAyAIG7rNzM
 C2sXMCqehbrRwDYEtaTJopwJ/5TVtl51ieXnn15/9A7dwQKj9vZZ2ihBsj6LgsxYTNt4
 azHAM0XkxRKhJ1Jojr5Ir0I90Jlzmj5RqUGjUNSg3y4rIC8mBSBbMZbdN+moSuQeNiA7
 tYE2gxWAhHUN0rXrNeV51vQJQhCR97IuMBZD1JKe0XaRXEwoDI3+CN3B1mPwEIX6WDjj
 P+t5KB2IPW6KdEquite4plAAnAkiAaOYJ7g4x+fsWlrpSvoQNEXdiwW6JZEa9RLdHdDB
 Rpuw==
X-Gm-Message-State: AOJu0YziFVCpep8p7cTT6wk4x7Sf2RhdNk+IixOndLbBcwF1gmoEarSc
 yo3qDIv606DJG4ySjwzC4/VnHgfRCdNP0rQ+31LnTZrrkz6QksYgoQvKzeKaAxN3
X-Gm-Gg: AeBDiet3OcW3gtNOetQ+NU1FkoRkEuf76xLw33DQ/XJlhjEsEMBK3H+0pmawTaBfYIj
 AeUOsXTW7x4MNG6BSjzyVuHDqqrmevHX4d6MIbZziLjcT/LkHF/0ctQo2qqr3ZidK4zezgXCr/p
 A35ysd25QtY/yAYKAOuFcz5odW/Quzg8jcAk+iHStif2BQbTg7rkd/e8oshGcakFGJWeIDxwrPK
 q7ml+jLEHGS8bjomfrJvHfUOy8/Voua3huLaGJE20QInn4OX7PFqaAbRPmK7uWsTX6nHCqefZzX
 1pu9p86P6/kuO9xfrHNL7/xi7COMqLteRd1NniaLGXFamDMz4JQ/YAb8D9/YzfpuXXl1wjeBdlD
 cb3tJJos9H859Hfvbj+/RupPtdAdfwq4boh+qUabuuUlLEYlvOzFhA2e+NtyA2I6gaIZ7CPuPCW
 T0hI01es2aJ/KrUlyWaUI/2vtT5XZ3JBb0MHSBv1y21YGZ/H6ZI0JSsz16s6h+qrC5hpJS
X-Received: by 2002:a05:6512:308b:b0:5a4:5dc:4e17 with SMTP id
 2adb3069b0e04-5a41728dd99mr10826333e87.0.1777049909459; 
 Fri, 24 Apr 2026 09:58:29 -0700 (PDT)
Received: from [192.168.1.39] ([185.135.151.221])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a41d85f704sm5144324e87.44.2026.04.24.09.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 09:58:29 -0700 (PDT)
Message-ID: <4171a035-8688-4a49-ab28-61e3e0b67ed0@gmail.com>
Date: Fri, 24 Apr 2026 19:58:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: fix off-by-one in uncore env bounds check
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>, stable@dpdk.org
References: <20260416111156.53750-1-denserg.edu@gmail.com>
Content-Language: en-US
From: Denis Sergeev <denserg.edu@gmail.com>
In-Reply-To: <20260416111156.53750-1-denserg.edu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Recheck-request: iol-intel-Performance
