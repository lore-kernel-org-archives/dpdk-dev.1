Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2C2CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 16:10:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B76FF4028E;
	Mon, 27 Oct 2025 17:10:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E18474028B
 for <dev@dpdk.org>; Mon, 27 Oct 2025 17:10:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761581436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A80X9pTT1z1aVIPf4CLaJ0LQym3ctvnQFYdmcClFqBQ=;
 b=dSXJMrVZOSxXPqy81h5+/OuZlSWcNC91cVcOyQ+l8zkd/1/MfSKzyEgF4O3mrSLrZoq8yQ
 lcgHitJqTVYb812o7d4TwKtgqxEBBzmq/8NbuDipnNxojKKYTfHpx1xYTUdeSChQMhA135
 BBGteAJMfMtb8ea7wiIXtso/RVMvyRo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-Oq5IUMiTOrOYelf2UyW8hg-1; Mon, 27 Oct 2025 12:10:26 -0400
X-MC-Unique: Oq5IUMiTOrOYelf2UyW8hg-1
X-Mimecast-MFC-AGG-ID: Oq5IUMiTOrOYelf2UyW8hg_1761581426
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-427a125c925so2414726f8f.2
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761581425; x=1762186225;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A80X9pTT1z1aVIPf4CLaJ0LQym3ctvnQFYdmcClFqBQ=;
 b=DwjFaZNFaxWqnVuB+5xQLfFJeDqk16TPKVwVB7VvrHkEjR2sTe0dVFxvy7c4B1AoV3
 vgHGaRqIE+y78tAWhPw++l5gl+CT/xUE1ReU+BuQXF5ge2phMMRwMWS4EKRrD6H2hUx5
 iDSaMsIrP97qxxkgBH0XB2geYKCpB8yU7FPpa9YQqfHpbG/+rLQfcjf1VMZisUaZpIdc
 hh3eK4/eMP33mv1EI+CqpEDRfDMX2ZgGp3uXwnHHj8qTz0mmO5UCtq4B/SJnds7qSUpU
 MuDPDuCHqK0Tjujh2/PZNeywC1V916orh8Y8EP4uAkIvBgp/WpI18r/EbWR+B8UIISuV
 PwAQ==
X-Gm-Message-State: AOJu0YxGVTt80pOPUcnHcDpFfh3Er3zGu5gfK81xLubM4iz0lAF3l7dC
 bP7N6h4LvQlOSE16v1oUWlg7NzcgyydC3s5n0pE63RaBryZG0jgFkWuoDZJeSSxsTWKaYgtdWvw
 P1Neo774Fk7yBkGMVpZq/C09H672aJ6HbkyUUcLLXOxiATFcz2YKc
X-Gm-Gg: ASbGncsvWzkPnIlP90Odtr99NgbPzA+PQ8cDNM6StNAxAr7Pz0bzX7ENpVpibxS8NrH
 ok7trn9CkhKFLJaslv+z4FyNiFDp5d0yp1xdekd61AD+ZVx5FP7O4ld2RFJVca4O9fcsVLtS+FT
 QIKN85TlqTEmFroTRLvLFJ6DUe7bk9ytLkEH4+Pt/Az7klhyoq2QGeRJjldFl2dwCmETROWixZi
 4Hr88I+6Sa8abmbk6AqhO3JnpKqX2Rv+AkoqaPF+UkuWz59+ywkP0ACja8beCc4jhWu4c3UrGfC
 lcxhond5MXW+r/XPvN0BUVgDqT/cIrDRwzT6douKzFbQlDCoZA+QX4ChG3HB4OsUEJSXbbEmqIq
 TduMJRzAP6zgovB9CH5aMsrA7vsbtbzNfA46CWsuYte/UBWrUl3BL+3zy
X-Received: by 2002:a05:600c:4691:b0:471:9da:5248 with SMTP id
 5b1f17b1804b1-47717e414a3mr1413095e9.26.1761581425630; 
 Mon, 27 Oct 2025 09:10:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPlvtULa+h/Y5i6yCGRmnXeQ82HSDtecwe8EyDGYCvwf0DzDI81mF6MuByoQnCoZK2h2Q4AQ==
X-Received: by 2002:a05:600c:4691:b0:471:9da:5248 with SMTP id
 5b1f17b1804b1-47717e414a3mr1412885e9.26.1761581425201; 
 Mon, 27 Oct 2025 09:10:25 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dcff9101sm73757845e9.1.2025.10.27.09.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 09:10:24 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 27 Oct 2025 17:10:24 +0100
Message-Id: <DDT8HYDZ6BS5.4UGBB34IPO3I@redhat.com>
Cc: <dev@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Subject: Re: [PATCH dpdk 3/4] net/tap: use netlink if possible
User-Agent: aerc/0.21.0-9-ga57e783008e9
References: <20251027153750.445275-6-rjarry@redhat.com>
 <20251027153750.445275-9-rjarry@redhat.com>
 <20251027090642.13524bf2@phoenix>
In-Reply-To: <20251027090642.13524bf2@phoenix>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rLXUpHWkHwLVEv46m-0t75Psv5RoOVlDKxSmJZvNEM0_1761581426
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Stephen Hemminger, Oct 27, 2025 at 17:06:
> Netlink has been available since linux 2.4!
> Rather than having two code paths, only one of which gets tested,
> better to commit to netlink and use it.
>
> Since dealing with netlink is a nuisance, I wonder if using
> libmnl would be better. Yes, it creates new dependency but netlink
> handling has been place with lots of Coverity overruns etc.

I don't mind replacing ioctl with netlink calls but adding a libmnl
dependency just for one driver seems overkill.

--=20
Robin

> Many suitcases look alike.

