Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C40D74EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:32:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C078440269;
	Fri, 23 Jan 2026 17:32:32 +0100 (CET)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTP id 6DC544021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:32:31 +0100 (CET)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-790884840baso23430007b3.0
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:32:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769185950; cv=none;
 d=google.com; s=arc-20240605;
 b=N/aMy7MzIpQJ6QEaG+13WfjVNSIrmuS8xY3Oq1nNvpB6LBVv03fywCjnaKWZh/w0re
 UlGKi73cZNzNDzcgbBZ+cch0/Js2UJh+kdmY6qtYuX4ec5R05QAo7goZYxJZQTIYKZKM
 tUBkdN92tTx7ZNtCI563vjWpQ5CAFqnSMw7Yz/dMQnfhV4h+yzwvQAbHt6ay2a3ArUHB
 uNbedq3ahDY6DTWU1i3ZQ9pJ99c3093W2tx1VRBYh2+kjuluQgA3jZnehiT3Pw3TDChX
 wp4YMLSjAV9Vx2xATIlts/v17oZxQe5sC+QpkcsEbXheBG8YLm3jpN9vLcfjB+5JH+gu
 t7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0WPrLdOgGKpK6pQBmWB4L32HI2NRHewQCeWQL9afUPk=;
 fh=t5fxTmIhHP7ICzI8GpFyBvhQ3wv17aq4LHlcgffP2p4=;
 b=fTXxdqRXZzeTL5q2bP5CYwhPh4T0tR4bEzJtswYRso/0+88E0WXDWdktFq0tMWsyMa
 zwv05VIqgAC/vO+NKoVHKgoDSr0hGn/2h7jOG8m1imQXjO+RciXBS7ijW9zrE6Vrxkmc
 IOKG8/RUwn4z8FdjtKUt8Apf9pgn9JiTkogDTas0YXAAZhZsjqBMD1ujYVDWwuL/IGEZ
 1XxorJly/CBFGLe40UHCBcFvFG/Yl+H5QVzI0STyVj1kTW2OVpfNnzvRv6FKQixlhw8G
 ZMn9kPmcOCdj1o/80iltHyhVxX4TzK/gvgv6/i6HOvzebl4xM4KjRwn47JQFq4XGEGvW
 5Dvg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769185950; x=1769790750; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WPrLdOgGKpK6pQBmWB4L32HI2NRHewQCeWQL9afUPk=;
 b=OeHDnCSrE3/DrI7xcUELhY8AncUDVzqvneFGqcU2YVzTI/2a6ew5A0VoTSID58Hr9+
 k15F5R/2+wi1jJrOIbnfagEenc4t+jSTIdcFsvZoyIPtYKkuIUJLMdYrNpWE4zxXDBp8
 e28tfiEL2iqBsGM2fgTnr/AXOIdhsO4aeLkpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769185950; x=1769790750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0WPrLdOgGKpK6pQBmWB4L32HI2NRHewQCeWQL9afUPk=;
 b=ShZR8lwikbnaVupitUkyMdEcSGZk7BPkpx2+Ch/3bMN05Y1aXLD60imDtIPRDpU5K3
 jI7Wn0VlALXc1WOX1ECkJm0h9heWqUCBtdu6izsly5fc0qWUP3bJlsMQKGIM4mHSeklR
 /MFgtZt/nbvnieaIpxGrno+EhOxNwW71dSy+ZJ6YewDwg0N1AaVE7APLMwVUtVNmxvh0
 exhfOF1hGU+CJNHT7yCOeSkoUPxGmsLXy25ZkXJSZC8CZWijlXKcjq/boxmG/hnPDzhj
 bS87HK3wqWS7IPm6RFUfLl5VG2/l9wgEC8e4M2hY0udP21Kvj4Has+4uDpdFGJBL1f8x
 Fntg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt8kpSqeMZEOmZqZEdC0vu6W6x48FdeoGSu7CuWWfOrmEU78KvdvGGjWirb0b/5QESSy4=@dpdk.org
X-Gm-Message-State: AOJu0YwFX6dVGysI/P49b7ZquMLc7arnVtSh3JDbkB79KANU4/KAZc09
 1iuFCRUv7e65v6nfeQR4qmQcd3E+DK5QJqTnSZ+5frb0fAQc3D4XI3UFlkJvcUVSti9HaQBR0dk
 L0HC0f0e5b7eemqf3n3tS7P8XuAu6p1esOc0umsAKTg==
X-Gm-Gg: AZuq6aKuKJo/i1FtJy9s07o6RXQKXHj78vvubY7Y12w22ZdeFiVW4A+pMtjsDDFbX3R
 ByNdZToCUGTKlpnJ8Yg2HSIiCTdJAuNUHeN3NrenICNGZjnc5Uhcme+SXUtuKHRwZQRVv8p3mzh
 LZ8hmkdTt9WewOJKd0/eDYwYJureCBlM0lCtEv/3uKLhWNGxYEKdTwaxoPoYxdchkZPWHh/JeFk
 ldxemtDMU3/EputbOhle76EjQWQ/H/BKsQpTEWVZm864bjgM3B8jLwl0lTN0Kq80l6+J/f1b08L
 oGEpnSB6DpqY9UeydqQx
X-Received: by 2002:a05:690c:ed5:b0:794:1466:1b38 with SMTP id
 00721157ae682-794398ecaa4mr28978277b3.14.1769185950519; Fri, 23 Jan 2026
 08:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20260122214424.322422-1-abailey@iol.unh.edu>
 <20260122214424.322422-2-abailey@iol.unh.edu>
In-Reply-To: <20260122214424.322422-2-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 23 Jan 2026 11:32:19 -0500
X-Gm-Features: AZwV_Qh7YOVqdoT7fNXIY-froui1VqkNcl7j58J2_N9OjmdRNYMIihb99XtM1B4
Message-ID: <CABD7UXN93fNx3xp_CU8d4UroOoOoDmHzYb2K7A00JtdarjLmEw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dts: add find float method to text parser
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, probb@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jan 22, 2026 at 4:44=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> Currently, there is no way to gather floats from text using the parser.
> Adding a new method to find floats will allow testsuites to utilize
> valuable float values that are output from applications.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
