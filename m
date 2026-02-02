Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA73DD172CE
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 05:29:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1109B40670;
	Mon,  2 Feb 2026 06:29:26 +0100 (CET)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by mails.dpdk.org (Postfix) with ESMTP id BED3B40670
 for <dev@dpdk.org>; Mon,  2 Feb 2026 06:29:24 +0100 (CET)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-55b09f54e98so1180377e0c.1
 for <dev@dpdk.org>; Sun, 01 Feb 2026 21:29:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770010164; cv=none;
 d=google.com; s=arc-20240605;
 b=GUHF5lYa4qleL3TVwJh4bMfiw+0Qnwj3PYznzt8SrLX2XQxHCSgIZUkX7Sek1bxO9y
 QIQcf7T+9nCEHS4CBH4e54eYR4QMIdZSsOOVxXgQN/8C6QfKtmmfJIwZrQdkGqlLIQ5O
 VlfPBlRo+axH3X2yzulj4Ml8rXNJRCx2kGdicJM1HsD2KbsOWY3/IPW+K4EtmxtazLjb
 qUBXfJ5grgVaxMI8D9AGm1Q6a7vIqw6xArHxHIWqVwH7iXK7kRyHL/oEur4uch47sZmz
 nto0I9stQNi8613hWiqURbF8Xg7A/WCquQ2LuvmLZAodrSD8W4OZEj3QRv/OC4ZMIaXl
 8cRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YK4FlRcoFqTDlG4r6SuBb+2X46N6IXB+iwqM9OinieU=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=AyA6UhCsslqTvR0jaGYTYY4paEoK5w6IA87ZEiDROaj7C53SyW4O2fuExKK9XBB907
 sNH357rYRtYEsoK5Lm5JRnLNpAbrrRZOgQ4/9PbNNwfEXeEtNWh5CZP8MaKwBmbMTL49
 0xDYSd31DW8/VXeoeDDvnxelbSyYSVMox6zaR+M5ESg/1cjDjn3jAGu4LQh7yChqviKd
 fft2Xg5smySP0zKzBaAd3b3ElBN1PeNr9BPoZH0vomyNtfQDp0fZ8yvpJs+opTK0Pcat
 WnNzYutOz4GGfNnX18izYDnVlhmVVG+VxMGXlYYXZ3c4/p0rZI9f/PuXpmbFVI1DsFTt
 wOlA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770010164; x=1770614964; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YK4FlRcoFqTDlG4r6SuBb+2X46N6IXB+iwqM9OinieU=;
 b=Px/CHvmq0HJ+l6XQiAAuLJTm1VZsV3/tVh1ed9uENK30UzL6qp7mA2viCOtPJ8tetn
 otzidncYvPEvrwsXAk8JAdpJkQ0jLB8ALDoUpk2gQp8rqphOyzCS8yuSVmry5o1y2SFj
 xhhGpEdJPyJYiOJkWQpjv5UC539F7Htt74h5O/5G7nbdGdC3FldQ+PSXZRJdNDAg/535
 52P77tEnXhrnAqiEtyTCo9nF+kUZF29hPjjKljP3hLnDwp0aBt/lIuIRilyLAZv+zk7c
 q4Uf45JZAyTJMNOOkS6j3wMqTrKy6dSWZmMmBINrPX0fCl8txxS5RZsbONPFxOcRxoco
 i5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010164; x=1770614964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YK4FlRcoFqTDlG4r6SuBb+2X46N6IXB+iwqM9OinieU=;
 b=Dmgrfy+GX8JOda+nOqxeP2KyVglBGh0HFmhTOefav96phH7jOZrcEkMdtYRhm8YA/E
 hlEqxx59h4oZU2eIAyWpCmZt7SERw32Gg8RvE5ACJ9I/KcNwAN/leDbA/w95jG0ufFTR
 MRUQM8rq9rpMacoIYH1p5DlZAa2AwD4BxQG6xqLdbUFsJCeROUqCUsHzEaCHR2WSLNfG
 KDucX7jzD4ase8uRkKlsowtghUXrzHDbop/2Rv7TxyWnA+W/VTK/o2fTr9m0QkqQD89V
 heWg7W/gs1dSFxA0Fda3e6EUHezhdYcwqs9E8rxTTcjHBK3ZtGJ+xycTlGz6QPUT0Az1
 xTqA==
X-Gm-Message-State: AOJu0YyPqbrUJpRrASKgsJj2qV4WJi8EKSUxAGIcxDSAOm7uikIk6jue
 r/JRvtRXqCy9eUXQxxihle1s46OEliEabtoW9iaK/14HeJFAYM1VRds8NBHc4lKk9B55F4Vrwwa
 QJMsFnW/j97HlUNijVr2zpWzivtEy7m4=
X-Gm-Gg: AZuq6aIJ3VI47jfNcIsurMNXYklFgkAkNFetfTpJcCx9klRSFw4nL1SFD3jJE87kr5Y
 e3yV7vOdydGEl1IAKocFhsgVdVfQex+YUu/xz5dYHoeFYELJLXRE7FyM6f0paZq5sA1a6nzUiSm
 ewIgeKmlO2+gVxUl4T8Gjt9XPLrsz49PU9nxdhtJFLFBvCoTDxtuaCeJA6z6TBFLtBbdmtM/ANG
 BEcZ/7XFv2S+4wDs/9Yszf8ccWCSsa0KhJlJLNPV8ncmjHB8dX4gtIdRcZmLeWH0MerbKHGQzb0
 xXLgYQ==
X-Received: by 2002:a05:6102:390e:b0:5de:78e6:494d with SMTP id
 ada2fe7eead31-5f8e2667048mr3918716137.45.1770010163890; Sun, 01 Feb 2026
 21:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20260128093607.62908-1-scott.k.mitch1@gmail.com>
 <20260128191032.78916-1-scott.k.mitch1@gmail.com>
 <20260128191032.78916-3-scott.k.mitch1@gmail.com>
 <20260128170715.3bced6c7@phoenix.local>
In-Reply-To: <20260128170715.3bced6c7@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sun, 1 Feb 2026 21:29:13 -0800
X-Gm-Features: AZwV_QggRwlfQ0RnUttvb7eEBcdsuwEw-wFxfPwwyT1tMwzj52bcw6lt8-F0Tws
Message-ID: <CAFn2buCWrDGGuAvx0mfPKJMqOJjr-ftRPT6vWP=Guz1rO_N9bQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] net/af_packet: RX/TX unlikely, bulk free, prefetch
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
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

> Drop the prefetch stuff, it doesn't matter.

Will do.
