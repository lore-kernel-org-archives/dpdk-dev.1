Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D06CA9ECF
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 20:14:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D938B40279;
	Sun, 11 Oct 2026 22:14:23 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 272284026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 22:14:23 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so9130445e9.0
 for <dev@dpdk.org>; Sun, 11 Oct 2026 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791749663; x=1792354463; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6cHaHjpKeAIJBfPQfKKEmRtCUBymF+PwRZK8cfeuRLM=;
 b=QNE40OqS1kGBbqT6LdAEiNLo0W4E6KlYi1XnjGR+MENZuXWBTHuJ0Umm+Seq2SVo85
 bHrD7HNT31RmCxJywvyKSg37FlWrxJaSASnqr1S9Q7Ce67Q7Hhrci1wec5SxSjMinOZv
 F8GDdOEWDvB5Wl62CcAqJajVjVIeffYVmBucQzoZjOBGlavxjmedwfIDryqmjCwtLg7Z
 Z4mHlq5aC1/0Lmo+HI+DiZspobOv8lISWBAzOqeJYzHM3og1knpnbIKqtOOHAUYExxBq
 UlShnhTTLKB1FRoZFcz2zWqIr0yYidm8dGnkp+aU/+eL7d4ELSS92TJEgxmzKKcfH3eK
 gKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791749663; x=1792354463;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6cHaHjpKeAIJBfPQfKKEmRtCUBymF+PwRZK8cfeuRLM=;
 b=zxXpHhQe0wduZqvLs9zqOtdrYiYtocsnv7hRDwGGMeAy0T2oz9VfqNjvJ1C2ZMWuI2
 PoyMf8+da2Ls6RHP/TaoiC+kQCc7AYijk5idN7LZuG+WKDMgZLzA8i7scjOjsJYJ1dbT
 JhCyG8ITWUjU8dh1hhlRFNRwTOxCx/HO/SFgFE6OGzZ1i5aw8MCy+vaUPK2ec1HOaDpk
 zwnkZyAZwl0aIIscKGcJd0yylM6aARmnti2Wr6nZJIwslxjDY0yhBrXtz9Sp4qqtbtKt
 fPLWso1loA19wu7OGZg05hrWP5+p02iCcPRnLqJ2rBGHRWvFDLMMVxp+aSvlkfoXi8vh
 wgNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwV3QToH6E1uMi37YRD/OcAWM9H0GVAyFjMooZKfRfJPYhiSFFk6xTqj7H9gjskDpSMB8g=@dpdk.org
X-Gm-Message-State: AFq9FYKEKoQCeBri+IBs7UxgNE55YoRn3UszMDe50Ezg+vKn3P3UHoV+
 1Gg+baLaCYoMMtaiDeeI2MzF5VXdVb0XtaPALeKLEt81n2wCGNxAzD6s
X-Gm-Gg: AYBFou2Z09sGUJi8mTYoa6RcxCkK7w0JjMfbB6hoG1uHpWHfUcduMCRMqdJA3thyzBE
 hz3FEl8nGhJtbjM0RO+evk39ut5A+Td+iNqS8XWPTZppwnnngbEYxSPA3pu7/rDbpBByQ6KMcGJ
 I72zc35pUj6QQlfqqouxGN4ZpU+yfzltRQnoFrj3hPV6kZ9/pNyO2jDps4tuV2iS4u1GSCp9AU5
 d4lKOZOzK4uCEulw2Z6YelbzuDDt7T4w8sQ31NtG5HpDrdgBbk9XmWw241Ejq5BA/CVlC4RAGcS
 TMdT+zG8V5ubavUHXPNxLjW1VBVb5xgFsoQbs6u1FwAqZOUf/jN655/viah05DkX8jhdjDxDm+E
 ffN8dXNjgqciCRq9W5Ds2mUWpUmwoH4beGuG12f2VYo/813AJh1G/sUZ7rcaGyWxpLuuJSyPfE1
 MdY8/vDsrhzv8UzI9Oq37VCMS+cXjSMoi+yn3yDQEa9iGI0b4bIhUjkRnkJZdu3yFzUsU=
X-Received: by 2002:a05:600c:8208:b0:4a0:1b14:d00c with SMTP id
 5b1f17b1804b1-4a18e446f55mr138248405e9.3.1791749662331; 
 Sun, 11 Oct 2026 13:14:22 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.57.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea1021sm213934285e9.10.2026.10.11.13.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 13:14:21 -0700 (PDT)
Message-ID: <05be3f82-7f9a-41ec-9171-fdbf8571e991@gmail.com>
Date: Sun, 11 Oct 2026 21:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] bpf: remove redundant memory barrier on unload
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261011182158.124246-6-qm2k21@gmail.com>
 <20261011125016.15772f7c@phoenix.local>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261011125016.15772f7c@phoenix.local>
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

> I think this already covered by:
>
> https://patchwork.dpdk.org/project/dpdk/patch/20261008233649.1260843-2-stephen@networkplumber.org/
Sorry about that, I will credit you in v2. Since current patch also 
involves documentation update, I cannot just drop it, and I do not see 
your change in trunk.
