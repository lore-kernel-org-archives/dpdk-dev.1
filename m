Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F1CC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 19:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4B2F402D3;
	Thu, 17 Sep 2026 21:29:33 +0200 (CEST)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by mails.dpdk.org (Postfix) with ESMTP id 237CE402AC
 for <dev@dpdk.org>; Thu, 17 Sep 2026 21:29:32 +0200 (CEST)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f9f0b1eso223602566b.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789673372; x=1790278172; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dzV1nYUyALPBQsIFOXvGix0VX/U/Wg0zIxgbjWemvl8=;
 b=YdiN9ICzQNmi/aaC3QNyhimjwRuAlwOltAbXgtF/gbUVCwov4FqbN4um/+JeEXo/Px
 ax25JP1MxElpi4hyhUL/qupRNE6P+HlHHUb/XExI4De86P935wW2ax54P5AXKOe5I2U8
 xDvRxvjYr/HjkiJriobL+AjHszHmO1pl6klWn6044gk/kDDsz1ZyZcYbAUJGetuVVbH2
 k/sVzMB5lflW/5fYbV/AN16UF0bce/cffBLZ+/y3K3uuryD28HWSktStIaW2aUyca4zP
 V0WEKdh8z1hi3UwSnYMgVJBsKZHw80Eaqr/BmAcUyuyPsOSQMtT847NyPKcVaug3tIds
 nHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789673372; x=1790278172;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dzV1nYUyALPBQsIFOXvGix0VX/U/Wg0zIxgbjWemvl8=;
 b=zCVxT6FnTHtbKV6WbTiE1xIWWYlgTI/c91H2Ui+sBo6BcYaLNlb5BCYM32WG/xAzbL
 o+opAcFkbC5tuMKvW9Tph+rgjpoo5gzNmxgYWrX8KhifnvKncNe03fKsW1S7Ts+blRVJ
 M7dUBTo4/1r8EtTfHoauZ+Powce4ZtkTTPiBP5wVdvfcKcPLosQLyp+eco8MBt+JLSqS
 2hfVpk7mmzH2AP8o8iVUUBTAeX4vTaqSxW9kZKEft/aiWEuwrcDjH+vWCBQodjerVolb
 HvPaP2edPq+My88+RxwZZSK1pbnJvlIr1DxY1oHel48klJ6ZS+2HTrwmyyUOYpSNyTOb
 jURg==
X-Gm-Message-State: AFuF++nDJkEjVdMmlR32C1CvGBON5yMJQW+b39kFblKPdOHiiPmW22d1
 cl5peW8nyzw4f54gsypM3fNrKWKnVfPAqcbonfnfrlAeyWF/eu41rUf1JCDqNYSIZRM=
X-Gm-Gg: AYBFou3EhB8bEBXFcGo1sLQsLS+QrR/p5Pm+XIpFHO/TL2tmiJFO5/LjDYOnzSSppDb
 fNW1Kp8iulhWiAG/84ucHU0U2jIn4qtC9G7lzt3GpnISYtsIykdgHw4ZlFevwCI4O/U+bQCbluD
 DyEMkwpBJ4CMMW4nzyTPLE0ziEQSzMSxdI62N+1RZtUnNFH7QWBO71+EDo3MUvxrLy3BMvxcdDH
 5m+RNiIMPSakRz31ciKejnLZIvz996TWttNQWDWM0thoZ9NSDfWQuHJxjkZ76FtXq9kOr2W5waz
 hOh6D5+EKEwf5ZiKdmVa4A6Idx0/Cw5xc0To8UkdyiI3KUhb1L0CeR0o0jjVVrMfJKdBedCDBGq
 2344zYk1YJ/iJt509eK3h1fz5MeGJMPEctp2GD8KxaLpHr+anwR3oo+/HngmJKgZlDvy920LAiK
 2GQUKpu95D8y4yQuKF5uO3NpY6mayFtIKhG68RryGOfRFnyRfPCSh94gjbC4xKmZ7x9qtQDldLX
 fLJ
X-Received: by 2002:a17:907:3f99:b0:c25:2688:8212 with SMTP id
 a640c23a62f3a-c2a152ea939mr22671766b.0.1789673371474; 
 Thu, 17 Sep 2026 12:29:31 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.40.14])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de4add55sm322339966b.33.2026.09.17.12.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 12:29:30 -0700 (PDT)
Message-ID: <3babcae5-eb12-4aec-8c27-da50a06b4e65@gmail.com>
Date: Thu, 17 Sep 2026 20:29:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] bpf: make bpf_def.h private
To: dev@dpdk.org
Cc: Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
References: <20260911124414.63321-1-marat.khalili@huawei.com>
 <20260917151916.48749-1-qm2k21@gmail.com>
 <20260917151916.48749-2-qm2k21@gmail.com>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260917151916.48749-2-qm2k21@gmail.com>
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

Apologies, sent the wrong version; please ignore. Will post v4 tomorrow.

