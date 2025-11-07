Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB86CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 08:34:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D6F440280;
	Fri,  7 Nov 2025 09:34:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E103C4021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 09:34:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762504496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lCDUMJ7ADFkWVPzAyBL62lHg2pHcPIZtyO9nBt3j5Jc=;
 b=H6PZI1RQgJ4cXtOSz14OdbV+lMtmLMZp9RQL+TL4Fc3mAyORB56g4ynEdeLvztiwVDbfgJ
 MrQV9SYCGzE6Z2x3plxke0jlvW2LqQhjfgiAAyS9ZJtQagw7EXvz3P0wm2G9ZTU40LTCfJ
 GQN5QejvAfu2eKdyLrVltvoiuaEfAmA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662--_kYTAxINzu06h_aL8qQFg-1; Fri, 07 Nov 2025 03:34:55 -0500
X-MC-Unique: -_kYTAxINzu06h_aL8qQFg-1
X-Mimecast-MFC-AGG-ID: -_kYTAxINzu06h_aL8qQFg_1762504494
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5942c1f786aso310085e87.0
 for <dev@dpdk.org>; Fri, 07 Nov 2025 00:34:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762504494; x=1763109294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCDUMJ7ADFkWVPzAyBL62lHg2pHcPIZtyO9nBt3j5Jc=;
 b=p0wa3YHbVcVidhl9Fpp9Eod2GteeARIUcObjmtF1TPGQn7b6MYDe0xxE9mhwR6nxvq
 cmcxXBWhAQJa64JhVM3x92KZQQHtvATmHbo9pQkZviR9i6iPSQ4GcfOlaimyLIt6a+gx
 GN3IpIEjkUwx39ZZ6YEXd/P1nn/4dO0844blI030gLxJ/qvEQgqjzIvTSyDfHHLTYvBY
 aqvNlvOL1yuOuHdvWALGFaofm7mUYLV4TbU0V/YP7rXfVtwFPszfF8j/BQlNrVooKtV3
 SSGXRyNtbIZIAM++uQ/u9EoxVvD5bh/Ocz7uxHGQYOxTF1eHeUL1cZSYbWTmqSHqmn23
 2IRA==
X-Gm-Message-State: AOJu0YyHi9KUQujw7efnFEewGmZUEPy3R11qBcyQCwzoIe3EnuLOk+Uh
 0JE/7KXqlFULz27iXhN2dkJeB3tYuiRFJ88e0ZHrs0vNvfntV8Lu1aDXuqtpzngv5TsNnbEa90h
 mObW6sQWVYk8EXOMLp8tGgmFf7jlfWLk77WwxyEwlNuZCK1gF63DvZoF92MXmoSL+IuOI1fBfpc
 AnU4SZELwyFZ3BPZ03TOA=
X-Gm-Gg: ASbGnctc1MYEivF71kUAaFlRpHz/vEngPr3BZMk+UuGOsg35c1iZLpafIjwSwEm5X7P
 toOpQG03/z+MMPRXVqzOH6C/75UAfRPHIG0A70vfq4afzz7hTono0GVZ7M797Auega6/RR327X9
 T+Za066s0dE9y+Nm9WhoNqcYtOLCesYWJPnKLz6UfJ+Y91LuVvLP03loM6ZA==
X-Received: by 2002:a05:6512:3e02:b0:594:51ac:148 with SMTP id
 2adb3069b0e04-59456b4ff22mr669459e87.15.1762504493625; 
 Fri, 07 Nov 2025 00:34:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOa7KiWqyK6FP2kE3wAiFT6Opk818PbDBOLZLHcd7Vd6tBSZlDS3cRhQGs7PqZ+PyDoSKcuowfjXS2t3ub/kM=
X-Received: by 2002:a05:6512:3e02:b0:594:51ac:148 with SMTP id
 2adb3069b0e04-59456b4ff22mr669455e87.15.1762504493215; Fri, 07 Nov 2025
 00:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
 <20251106163807.201451-2-hemant.agrawal@nxp.com>
In-Reply-To: <20251106163807.201451-2-hemant.agrawal@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Nov 2025 09:34:41 +0100
X-Gm-Features: AWmQ_bnasA5fbL2X7oNaL_vXrFCcVaq3sjuLTV-y_cFNkdYF_c0IwcbhX85pfcA
Message-ID: <CAJFAV8yy2eHWML_mKkJLqGDaiXozZNMB82CGC04O-epWmkM-2g@mail.gmail.com>
Subject: Re: [PATCH 2/3] net/dpaa2: clear active VDQ state when freeing Rx
 queues
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, Maxime Leroy <maxime@leroys.fr>, 
 jun.yang@nxp.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OJAgkQvdkEZtfT4VDsP7CmyGeEL8fym7JUsOkrVS6DQ_1762504494
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 6 Nov 2025 at 17:38, Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> diff --git a/.mailmap b/.mailmap
> index 10c37a97a6..1f540f7f51 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1036,6 +1036,7 @@ Mauro Annarumma <mauroannarumma@hotmail.it>
>  Maxime Coquelin <maxime.coquelin@redhat.com>
>  Maxime Gouin <maxime.gouin@6wind.com>
>  Maxime Leroy <maxime.leroy@6wind.com>
> +Maxime Leroy <maxime@leroys.fr>

On a single line please:
Maxime Leroy <maxime@leroys.fr> <maxime.leroy@6wind.com>

>  Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
>  Megha Ajmera <megha.ajmera@intel.com>
>  Meijuan Zhao <meijuanx.zhao@intel.com>


-- 
David Marchand

