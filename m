Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD755C3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 12:52:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D83CE40E1C;
	Mon,  5 May 2025 14:51:17 +0200 (CEST)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68]) by mails.dpdk.org (Postfix) with ESMTP id C08AB400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 08:19:06 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso1901019f8f.0
 for <dev@dpdk.org>; Thu, 17 Apr 2025 23:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744957146; x=1745561946; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OuM4ZwTjVn3YuAxNQm8VzKi8IfnyHZWkvzyZXWb17mk=;
 b=dZ4AN7e67xz1/v8607/9eya7K/W7qIg5FbIVoVQITkdlTiYt9H9pwHqH+yNdwLtVLP
 6LKhFBBo7J7YLOPSyL08uwEXNpnF5TuyyoxEago4qL8eWxMZG2NPRaW4jkRLrCvQq5Mh
 lWGkR6JgH1V/LxhXTl3+Zdw08wIVyluZVOhdKt0PFehpSl5mkVAJ6IcjLIB+qq8iO0FC
 ZPpnYi26+Ow664cPbnTMxHg8EPf3G9KWxVYbn6Uw5XA57SB+AezAGdRhWaKXcg/sJewf
 vOIJ3+r4E6dvHBmeuIfN4sCvGDw/p8qvbN2wh2UQTAJeZbh/a1IwaJHwkUXUnbHZt0Na
 sWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744957146; x=1745561946;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OuM4ZwTjVn3YuAxNQm8VzKi8IfnyHZWkvzyZXWb17mk=;
 b=iXkqXPIX4yO8DFI8GtD/ru07/fuaVKqnraM4rHQC3alTeR8QqF3nXDBq4DkzY33T1M
 7jvuNYrDcnmlodBit2/UxGAHBgqYHsirAaw8+BMYZYSyOUYqlipktQxwGutUFqY1aG+p
 JDluSDS0swC/FCPxETBJmz6zlsHOfiWVrRde8KBjaHzDpxEoqSGOQvYlTQqyaUfEfrq6
 21fEpYZfmMM9AjAe8+jcJLbscwrdYXJXD2rj1hRSaCU/EAWFFp/YddavZ05Ful5r+PGT
 PObYBsdP1CH4TjashQnxD8gTd+g397kEGaNjRe5uHNCu99jIwHco42qwZo5eg/nWXm9D
 xP0Q==
X-Gm-Message-State: AOJu0YxFPZ3Y2lY2zki4TEimryUXm95t185aaqan8ff5HJ4MdMCOum1Y
 WeKiwQzOwV35HMQDuMB2PRryVAyGV0ZI9KkUwTgm8xs/NYVtIxPQp1t08ufeeGavn4+2MCyJBtV
 PKiziSse+QzEyjXTFgaXTKiyV9T609iYFsXZUTw==
X-Gm-Gg: ASbGncuHUr96340ifEbs7mVmH8KvEfKUqzgS+8YuktfnkmyjhFHj0wiPo7nE/fzxA87
 VDzDUM5BicCY866A5xSODGKvrNfmo//ZFF+Pj8orEfUhqUUXV0g/Se2rlzYcu5gF/kVTK0STsaT
 V1vriQx8MYj7qxAMTL7fwGMDO8
X-Google-Smtp-Source: AGHT+IFSQUi6J6ndEF/7AjXwr5HeONMONKoSwclRbJol1q+WqI4aUrxr//ZZ5RIiURqHY/Se5fFMQAZB8sDzgLwKMN4=
X-Received: by 2002:a5d:584e:0:b0:391:4c0c:c807 with SMTP id
 ffacd0b85a97d-39efbaf2131mr1094692f8f.53.1744957145937; Thu, 17 Apr 2025
 23:19:05 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5q615LiW5Y2a?= <duanshibo.d@gmail.com>
Date: Fri, 18 Apr 2025 14:18:54 +0800
X-Gm-Features: ATxdqUHehic_IUFKgcTpYqz40Uey2Za7Sf8JxGA7jWXmGB8QW8FwCRmASmMUNxs
Message-ID: <CAEPTqQYGLYV2oE4GGdgrB2AajkiMNDPqazebYcc7c_WGp65kAQ@mail.gmail.com>
Subject: Use external_buffer by ret_pktmbuf_attach on dpaa2 device
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000d4ffab0633077e3f"
X-Mailman-Approved-At: Mon, 05 May 2025 14:51:06 +0200
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

--000000000000d4ffab0633077e3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone, we want to use external_buffer on the dpaa2 nic, but when I
use rte_pktmbuf_attach, the network card cannot read the content of
external_buffer correctly. When I map this external_buffer through
rte_fslmc_vfio_mem_dmamap (an internal function), the network card can read
the data normally, but I don=E2=80=99t know if there is a problem with this=
 use
(some restrictions that are not considered?). If this use is legal, I hope
that developers can add dma_map and dma_unmap functions in rte_fslmc_bus,
so that memory mapping can be completed by calling rte_dev_dma_map. Thank
you very much.

--000000000000d4ffab0633077e3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello everyone, we want to use external_buffer on the dpaa=
2 nic, but when I use rte_pktmbuf_attach, the network card cannot read the =
content of external_buffer correctly. When I map this external_buffer throu=
gh rte_fslmc_vfio_mem_dmamap (an internal function), the network card can r=
ead the data normally, but I don=E2=80=99t know if there is a problem with =
this use (some restrictions that are not considered?). If this use is legal=
, I hope that developers can add dma_map and dma_unmap functions in rte_fsl=
mc_bus, so that memory mapping can be completed by calling rte_dev_dma_map.=
 Thank you very much.</div>

--000000000000d4ffab0633077e3f--
