Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A81FCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:45:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52C044066A;
	Wed, 24 Sep 2025 17:45:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9F36C4066A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758728754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MN1eugF4tnVM+CSPf5lgA5B5Vg97egF6ic1/8vmgE5Y=;
 b=dQPxLGphbqX27O4EYnYSCQuqqxXm7OfJTo0vLYGQsvhzoHTtKPp0Jv+fLsN1e2xAJKf0nT
 HLlpIdGGilzaI9TeOmpLgUZwxt1SzNS0by2MvT8UmWwtq+6EQFSCYkqGblnwYLrblDtjok
 P3Ba0xdu6kCo6EJypavQFkmN9bMjoK0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-WwLhT0GbOq2cR5sgxzxIug-1; Wed, 24 Sep 2025 11:45:52 -0400
X-MC-Unique: WwLhT0GbOq2cR5sgxzxIug-1
X-Mimecast-MFC-AGG-ID: WwLhT0GbOq2cR5sgxzxIug_1758728751
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-57bccf22e0bso2934592e87.3
 for <dev@dpdk.org>; Wed, 24 Sep 2025 08:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758728751; x=1759333551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MN1eugF4tnVM+CSPf5lgA5B5Vg97egF6ic1/8vmgE5Y=;
 b=MQhj960FCVDV3tdyCmLeP9WtL2dpO5rQGjLO2kxgeodQjncIq+qs2g+b6/NqkF8foi
 YGOYqWIcEbT7xIyfEQrFUJMnA/BIFGOpBHaFvA5zRfnNrUNC9BWKtiPZ9ytvWtNBvIUi
 5f4cVDiyDqCZnmJ290d9fJ2LTV2TBdn7WnVpI5sn2oYGN+BhwYGoEaVL5mnSO4yiMrMF
 Uxxw+Z5rW4+lQ/htXt2sSpsLbdxhoOwymImsmZVQVIeJZrC1YwBqlThPWEytd3CWUV8h
 q8guVxAf153bsFYAIKUIHoAboz0ja3MKd8uHxq9MydxYh6yZtN0+j2IsX7+rRPaklCaA
 omjg==
X-Gm-Message-State: AOJu0Ywu09LtIIZxzaGX5Bg4iNE7JsHgXsQ2T+jZYQu+ILs1QrFuBO5r
 HHvHgdZ3DzmDaYuqIyI1JmNxSvGTZOM3c5emlEalhBi3inEFCscqwAb2JmIUnjo28u24sJ0Hey8
 rZSXDzgkKQClX5fVRTVUFSnntUhXyeR3ApMpBNX4Z5w0HKhrqMHzZC4f1srHSHRIaBsD075eR6J
 3uDmgpnhQGvlg0fB8IAbU=
X-Gm-Gg: ASbGncsYpDc89qVKpnJ1h7W97g059OBNZIIrX+TAbCyrh/UCfHg4b0kCfxkQeUGNGLD
 ugEQdGe3d1wCxbFA7kYFUoGYugBO+XxZRkWOeWA/L3NKhi9z8ZHQD33zNsTtDkOcAKA4Nc0VvAP
 FUsorq9dxVb9+R00+4zaCWqCw=
X-Received: by 2002:a05:6512:10c9:b0:55f:44b8:1ecf with SMTP id
 2adb3069b0e04-58070328f0bmr2446414e87.9.1758728751130; 
 Wed, 24 Sep 2025 08:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzZseP32tKnx8tC3MDcEP+I1LdsxisSKXBnLuCAQXcd94KB76F89w/d7+NKXo/UQQtFE5z6B4nFUTotri0WAc=
X-Received: by 2002:a05:6512:10c9:b0:55f:44b8:1ecf with SMTP id
 2adb3069b0e04-58070328f0bmr2446404e87.9.1758728750750; Wed, 24 Sep 2025
 08:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250919075733.221023-1-bruce.richardson@intel.com>
 <20250923144000.13570-1-bruce.richardson@intel.com>
In-Reply-To: <20250923144000.13570-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 24 Sep 2025 17:45:38 +0200
X-Gm-Features: AS18NWAferoms-WpZckQAu90dJBn511eKYvPv3PCzlek1buO7TIUf3eL5WM2XU4
Message-ID: <CAJFAV8ySAMbErqh_9_gy-6FK+OP+8D4vvsn1iYYNniYGBPZT7w@mail.gmail.com>
Subject: Re: [PATCH v3] build: remove deprecated kmods option
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6jrvRyrD7hOowcCkjEKTmOEQeFjMvYLvpnOZL745Cxs_1758728751
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

On Tue, 23 Sept 2025 at 16:40, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The "enable_kmods" meson option was deprecated back in 2023[1], so can
> now be removed from DPDK.
>
> [1] https://doc.dpdk.org/guides-23.11/rel_notes/deprecation.html
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: David Marchand <david.marchand@redhat.com>

I see errors coming from Intel CI that requests enable_kmod option.
It needs to be fixed on Intel side so we can merge this series.


-- 
David Marchand

