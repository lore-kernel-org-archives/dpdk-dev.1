Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D3AC7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:33:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E7AA402D2;
	Sun, 29 Jun 2025 19:33:12 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id CD89C40288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:33:10 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so3468249b3a.0
 for <dev@dpdk.org>; Sun, 29 Jun 2025 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751218390;
 x=1751823190; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vns7Hf5+9ou9/9JcZehWdmASU5yM9n678ylxi1LI5xc=;
 b=eZZ1SpsnJ/0XOS7lryTnc+FwDtJEcPs+MZ7rJNZvjZt/4T+73hkJOrw/K5ldp9hnWZ
 UL7CkYGDCi+5CywiufwfhCbKg0lOvYebu22KjfH26jTvYXNT5ELRdqD3TVYtDD/hggLu
 M3zBo8Uy/TWTG9Olyio40ciEhD3Jk9ZYQltL6uO35eXsGttGGaHErrMFlKWlXfq7sElp
 X4528Bo+es42VZVw4PSZOSH9GjnrH6Qi/AkEf86Ac8IaJ7cVvbv53UiVs3LQ5oDZyCIf
 bJ71Iaa9hTJeLXnCTUs2cnvSYGFOQ1W2670Jr6IMYzHSIY0eXo6L3SpnJsSjAr5bP89q
 hYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751218390; x=1751823190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vns7Hf5+9ou9/9JcZehWdmASU5yM9n678ylxi1LI5xc=;
 b=USiHW0VNLFDIQEA/0Aix3083bFeL/mCFmnDj9IzAQZyDmNWpId7ScU9MsEs7fEh5Wd
 x69+IfhJoxY6CRgMfy/RaserlhBoL9XleDj9DNWi/ixaEM7uly2Za+S3xQklzhF+0ehl
 veH71ek6lOekYdrNwX6n0vW3jHLdWbVHAyUinTe5HvrQ4uW5hHTERyGYzZMFmB5ylgAf
 TJjXQojGpoNIyTXLsJp9aV6+ZksvEeyKlLiOWc5lyKAs879QGz8XJRUtu4QkdpxrgW2P
 OHVgMSEv3uefQQRLuZBpc7U6ZwPlYeV+KqO7t0WrGIdmWi5JVfGF3c2LzZB80DD2z1kc
 2BHw==
X-Gm-Message-State: AOJu0Yx/gOujoC0tqjVeFG4CciVstNkmArkLM+8eyu/LPFUPo//Bgi0y
 NJd8szJeVVEZ89XuT5HGsTmuSSLimmKCEPUfISoRBKED8fbyULku8ZR4+1dEAhpXUE8=
X-Gm-Gg: ASbGncvNQlLLWh29I0E0HDvgEESFFPrf+Xknt4DFbzxfxlDRhNRjT5GgUiLUpYP4z/s
 5KwccBbR+IsmBoreQWcR3OXOIr1KJZdA/8Nl5XHePgR0hwf1TDzUl3brXnLEO8vGzM98XdYSbvJ
 HVO6khqFC9+CdGTjSDIO+QTTGjuVMKjwOKJYhILl1PrPc7Zp3PF3PjZnJ4QDPAIwImIoV9vNpzS
 OqxpjuFopP2sEf4Ru4eamiv0YOLFW9L9w2Ey46hWZ/MJ8Bclu0Nv+GX7NeeYa4fp+EyUUzwOsHD
 QmU7y6BdIiY2hNopEcbT1rekrkmSnQ4bQXAOOjWohICsenxRw4R5h4g7J21QRyPitSEjDRkMhGx
 a5GNT7wei1su4FUP0EtEqri1kmfq0ei1j1bMOlf8=
X-Google-Smtp-Source: AGHT+IGzI50/CQ5r15FmbA17Jtjha2xtdiwMYIGS5XZT0QxZp1flpCDodBZcMBwnO8PyQySsJ6x6Bg==
X-Received: by 2002:a05:6a00:88c:b0:742:ccf9:317a with SMTP id
 d2e1a72fcca58-74ae4130d45mr19508403b3a.12.1751218389883; 
 Sun, 29 Jun 2025 10:33:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e31da944sm6128976a12.60.2025.06.29.10.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 10:33:09 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:33:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v3 0/8] net/r8169: support more cards
Message-ID: <20250629103308.0f4f93d2@hermes.local>
In-Reply-To: <20250611031001.20306-1-howard_wang@realsil.com.cn>
References: <20250611031001.20306-1-howard_wang@realsil.com.cn>
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

On Wed, 11 Jun 2025 11:09:53 +0800
Howard Wang <howard_wang@realsil.com.cn> wrote:

> This patch series includes the following updates:
> 
> Add support for the RTL8168 1G NIC series.
> Add support for the RTL8127 10G NIC.
> Add support for the RTL8125CP NIC.
> Update hardware configuration for RTL8125 and RTL8126.
> 
> Howard Wang (8):
>   net/r8169: add support for RTL8168 series
>   net/r8169: update HW configurations for 8125 and 8126
>   net/r8169: add support for RTL8127
>   net/r8169: remove cmac feature for RTL8125AP
>   net/r8169: add RTL8127AP dash support
>   net/r8169: add support for RTL8125CP
>   net/r8169: add support for RTL8127ATF serdes interface
>   net/r8169: update HW configuration for 8127
> 
>  doc/guides/nics/r8169.rst              |    9 +-
>  drivers/net/r8169/base/rtl8125a.c      |    8 +-
>  drivers/net/r8169/base/rtl8125a.h      |    1 -
>  drivers/net/r8169/base/rtl8125a_mcu.c  |   24 +-
>  drivers/net/r8169/base/rtl8125b.c      |    9 +-
>  drivers/net/r8169/base/rtl8125b.h      |    1 -
>  drivers/net/r8169/base/rtl8125b_mcu.c  |    8 -
>  drivers/net/r8169/base/rtl8125bp.c     |    5 +
>  drivers/net/r8169/base/rtl8125bp_mcu.c |  200 +--
>  drivers/net/r8169/base/rtl8125cp.c     |   73 +
>  drivers/net/r8169/base/rtl8125cp_mcu.c |   78 +
>  drivers/net/r8169/base/rtl8125cp_mcu.h |   10 +
>  drivers/net/r8169/base/rtl8125d.c      |  104 +-
>  drivers/net/r8169/base/rtl8125d_mcu.c  | 1479 +++++++++++++-----
>  drivers/net/r8169/base/rtl8125d_mcu.h  |    2 +-
>  drivers/net/r8169/base/rtl8126a.c      |   17 +-
>  drivers/net/r8169/base/rtl8126a_mcu.c  |  900 ++++++-----
>  drivers/net/r8169/base/rtl8127.c       |  385 +++++
>  drivers/net/r8169/base/rtl8127_mcu.c   |  601 ++++++++
>  drivers/net/r8169/base/rtl8127_mcu.h   |   12 +
>  drivers/net/r8169/base/rtl8168ep.c     |  221 +++
>  drivers/net/r8169/base/rtl8168ep.h     |   15 +
>  drivers/net/r8169/base/rtl8168ep_mcu.c |  177 +++
>  drivers/net/r8169/base/rtl8168fp.c     |  195 +++
>  drivers/net/r8169/base/rtl8168fp.h     |   14 +
>  drivers/net/r8169/base/rtl8168fp_mcu.c |  270 ++++
>  drivers/net/r8169/base/rtl8168g.c      |  297 ++++
>  drivers/net/r8169/base/rtl8168g.h      |   15 +
>  drivers/net/r8169/base/rtl8168g_mcu.c  | 1936 ++++++++++++++++++++++++
>  drivers/net/r8169/base/rtl8168h.c      |  447 ++++++
>  drivers/net/r8169/base/rtl8168h.h      |   21 +
>  drivers/net/r8169/base/rtl8168h_mcu.c  | 1186 +++++++++++++++
>  drivers/net/r8169/base/rtl8168kb.c     |    5 +
>  drivers/net/r8169/base/rtl8168m.c      |   19 +
>  drivers/net/r8169/meson.build          |   14 +
>  drivers/net/r8169/r8169_compat.h       |   78 +-
>  drivers/net/r8169/r8169_dash.c         |  447 +++++-
>  drivers/net/r8169/r8169_dash.h         |    9 +-
>  drivers/net/r8169/r8169_ethdev.c       |  122 +-
>  drivers/net/r8169/r8169_ethdev.h       |   39 +-
>  drivers/net/r8169/r8169_fiber.c        |  201 +++
>  drivers/net/r8169/r8169_fiber.h        |   42 +
>  drivers/net/r8169/r8169_hw.c           | 1841 +++++++++++++++++-----
>  drivers/net/r8169/r8169_hw.h           |   74 +-
>  drivers/net/r8169/r8169_phy.c          | 1018 ++++++++++---
>  drivers/net/r8169/r8169_phy.h          |   16 +-
>  drivers/net/r8169/r8169_rxtx.c         |  275 +++-
>  47 files changed, 11315 insertions(+), 1605 deletions(-)
>  create mode 100644 drivers/net/r8169/base/rtl8125cp.c
>  create mode 100644 drivers/net/r8169/base/rtl8125cp_mcu.c
>  create mode 100644 drivers/net/r8169/base/rtl8125cp_mcu.h
>  create mode 100644 drivers/net/r8169/base/rtl8127.c
>  create mode 100644 drivers/net/r8169/base/rtl8127_mcu.c
>  create mode 100644 drivers/net/r8169/base/rtl8127_mcu.h
>  create mode 100644 drivers/net/r8169/base/rtl8168ep.c
>  create mode 100644 drivers/net/r8169/base/rtl8168ep.h
>  create mode 100644 drivers/net/r8169/base/rtl8168ep_mcu.c
>  create mode 100644 drivers/net/r8169/base/rtl8168fp.c
>  create mode 100644 drivers/net/r8169/base/rtl8168fp.h
>  create mode 100644 drivers/net/r8169/base/rtl8168fp_mcu.c
>  create mode 100644 drivers/net/r8169/base/rtl8168g.c
>  create mode 100644 drivers/net/r8169/base/rtl8168g.h
>  create mode 100644 drivers/net/r8169/base/rtl8168g_mcu.c
>  create mode 100644 drivers/net/r8169/base/rtl8168h.c
>  create mode 100644 drivers/net/r8169/base/rtl8168h.h
>  create mode 100644 drivers/net/r8169/base/rtl8168h_mcu.c
>  create mode 100644 drivers/net/r8169/base/rtl8168m.c
>  create mode 100644 drivers/net/r8169/r8169_fiber.c
>  create mode 100644 drivers/net/r8169/r8169_fiber.h
> 

Ok merged into next-net
