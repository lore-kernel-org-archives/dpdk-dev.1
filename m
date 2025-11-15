Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B189CEB2F0
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 17:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 426AF40A80;
	Sat, 15 Nov 2025 18:57:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D2CCA402A2
 for <dev@dpdk.org>; Sat, 15 Nov 2025 18:57:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763229452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcc0Zfckt1RdmOheODrtfaodKVset9EgFkhI0tlR6Gw=;
 b=SlkMJMQIOCNbfkL8N6pBJNewBxojMbzlK45BNBLT43WzNETDBl+pR2L6bvJ60GmmX5KBud
 q711P9y5HnsD920rqXkZAoZrgDg+LfsxsWecfVGFc8e2TAgwU4Hz+ZfGiRvtS8Zqh82I7a
 PdtjzfyVLlBeGfZypI9QG1dsi5OhSLw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-nantepH-PK2TayxZqry_ew-1; Sat, 15 Nov 2025 12:57:31 -0500
X-MC-Unique: nantepH-PK2TayxZqry_ew-1
X-Mimecast-MFC-AGG-ID: nantepH-PK2TayxZqry_ew_1763229450
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso16882145e9.0
 for <dev@dpdk.org>; Sat, 15 Nov 2025 09:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763229450; x=1763834250;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wcc0Zfckt1RdmOheODrtfaodKVset9EgFkhI0tlR6Gw=;
 b=h9tF5tFWJKWgqOFDQU01WBOT+WI1mSeL6HKCf0CvntKJFuJRf/16hrDG+oQI39vTh/
 Px+MOdBPYeccIsmj+toyhBF08l4zLbCtxm+0KC8o3NQt/qMC23D5vwTx9MmJ73aBPv97
 Uw2cbLHQ8nSWvJVvU/suE6aU9WPN+eZxPmN1UKiQN7kblSi8tUEHwCNVflK4yL1mlojC
 945SX8Logu+7Vwufp5WhXFsPwIjIEiKNqEnGAaAQsZQG01GNxE90Kc+zQhjCof9ntMxv
 Q5b1AaSa51Wu19Imqpq/P0rn5HcDTWgu/jlGgjqKsJgGuEnZID09bfIrNNCfUrJvWcTn
 H3Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE801Me1J90D/6yNpIIPfocwu53iin76/306dnnKIi4TBDNRYb7evOAANbGFCrTWBlKSE=@dpdk.org
X-Gm-Message-State: AOJu0YzTHzW0edg8ZrnH7k/wDOUNUbKN5QuZSlETpsYMVyVxb39KHrih
 5MYUoFyCpbIVGvmC1zIHJBUk4sO3bMDkHanidgXcWHf1GfOng1ccFuod6MapQHBs2VcMshz5Q9c
 Za6G1hvd70pDg9acBAO6N1Yz3EjOr3IjPDhSFgvC/yskj
X-Gm-Gg: ASbGnctC4yUtWsdGg46ww3z6Wsmh4KpBVc8saTRU0Cps0tFO99t6OJbwpej+3OQTqfW
 NX5wnZVZYNjTWRpm3WR9/ZiCnPTPSNCa+rbItLr5p6dQA3KxAF1Dw3ZkD0Nmnp2frQhjkv4KVyR
 adm4d+YlmZlKS/qtBGcUQ0KrlQekjYIVYOAOnkn0yv07ErWAQ36p7768zZSI7aQHdWK7jm1fp3C
 ZTn7cqOEtibWw+R6DT6aC3uk4F3r60JrzSo2LUkpIci5qWXCCmLJhvLqNJGj08DZcNAjpwN/30i
 IpEQcnzQHBmzsEGi9wbr0pp0Fze56ARQPtNOwq2jkf5ZFBMoIS/6RH5n8N6sLOeMJtTDSJnGTdM
 pzSP9TdM14cFS173uGjoDnRPryZzCp38SPbU6iKkTvNfBBuokgFHV89MbHw==
X-Received: by 2002:a05:600c:1c20:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-4778fe5db1dmr60406565e9.14.1763229449858; 
 Sat, 15 Nov 2025 09:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOiID+68/tQfF12lDf/pbTIgPKTHyRcmBHu5VTf18Y5/ptyRe82Iuh4MEXhN63SrqkRX9m4Q==
X-Received: by 2002:a05:600c:1c20:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-4778fe5db1dmr60406425e9.14.1763229449491; 
 Sat, 15 Nov 2025 09:57:29 -0800 (PST)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bd27e97sm74515465e9.7.2025.11.15.09.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Nov 2025 09:57:28 -0800 (PST)
Mime-Version: 1.0
Date: Sat, 15 Nov 2025 18:57:28 +0100
Message-Id: <DE9GOA1Z26VT.1SI0QQLH40U1J@redhat.com>
Subject: Re: [PATCH dpdk] net: ipv6 link local compliance with rfc 4291
Cc: =?utf-8?q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, "Christophe Fontaine" <cfontain@redhat.com>,
 <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
User-Agent: aerc/0.21.0-27-g605fd3b39ccd-dirty
References: <20251114105751.54802-3-rjarry@redhat.com>
 <20251114080532.1e86d13e@phoenix>
 <98CBD80474FA8B44BF855DF32C47DC35F65560@smartserver.smartshare.dk>
 <DE8KJK97R8KQ.3SC0EJPIEHSP3@redhat.com> <20251114090341.589bcbd6@phoenix>
In-Reply-To: <20251114090341.589bcbd6@phoenix>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ChoOsPeI8UQ413EDgAU6UpCL8Z4ITiLfDNy37iRaVUc_1763229450
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

Stephen Hemminger, Nov 14, 2025 at 18:03:
> Yes, this code is in first git commit 2.6.12 from 2005 it is possible
> (but not worth the effort) to find it in earlier repos.

I finally found the original discussion on the netdev mailing list:

https://lore.kernel.org/all/20050116115431.GA13617@lst.de/

And the commit that introduced this quirk:

https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=
=3Db74ac55d38c7181d1f1c1c3c7068b1693c7adb0f

--=20
Robin

> Post no bills.

