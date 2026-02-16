Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF6AE81A44
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 16:52:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AD3C402C5;
	Mon, 16 Feb 2026 17:52:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5E10A40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 17:52:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771260751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2+EmC9sABcugCImgrbdQdbNKRNTRfJ6ZJ5m1jwNdq4=;
 b=cQrEVu5G5Ll2Ym7qbG0YZptAo4sMQuHXaHq8uVLr5XddkT7+Hrj8moAfLii1LWGTRqs/7C
 rfSh0yFWFWT8CVTVM2zrHDE5nrLk/yl/wzdgt+gp+FR+X/5IHSnkLC8DvjUubNfigVaJEH
 gvRsQDK6Lsi4ChD9iGfatjqbpUEUais=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-LWMPh2bnPQmn9A3penK8Lw-1; Mon, 16 Feb 2026 11:52:30 -0500
X-MC-Unique: LWMPh2bnPQmn9A3penK8Lw-1
X-Mimecast-MFC-AGG-ID: LWMPh2bnPQmn9A3penK8Lw_1771260749
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59f731bf9bbso898384e87.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 08:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260749; x=1771865549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I2+EmC9sABcugCImgrbdQdbNKRNTRfJ6ZJ5m1jwNdq4=;
 b=rn2BniRlow4frcGypL0rOVspQJQXRthmGET7wcT7k4LSsBw1tuMj6gdXCoOA7iPC5t
 qJs+LeIgqptXolyf+HszljzjElBGAO9r8HoYihKsBdDiVzZKhuAiYkbckIPXGh7aUiyZ
 3WStZlFRRPUBNNV7Kec4mSSHL0qT8qR/blYA3ta42IVRxrnjB3pBGFnIYRRxHzDWq29u
 VSdlchiQjnHrwt0vwRnLG9i5QG3RyFJ+QjCReAYRaoHaV3fwAXOHStOhXMr8z8vinSEd
 q8eh5gufd5TF17KfrF+B4H5OvGiccdbviCFjAb2ZyAOpu1cUmT8fyKtxe3hHtOXLdWdJ
 XWbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU59xgTgidyXOjQ8oQuR6hGixH90bpu8MULRe2neDPqJVpmb7KoejeeSxbE2/t3sQcIY6Q=@dpdk.org
X-Gm-Message-State: AOJu0YzHlfC5u7CP99L/sA0wYtrsph9CSf5Gqvnx1k2RsXRZwK1YtMEY
 l36M5UufrDIMXjSGZESZadL27DG1QsKLPNsOkljnABLvpMO29QQbuFuzrJ88cZ0zkgaaiOFDB0r
 GkxeMTqpnLsPV6vbWvN5d4i9obSOw0pLvmjwvn8jMICeqgRYMLqXVFTQBR+DoJp3sjyAfB5KG1y
 pIYoY0tYiQU1oCfjHsJsk=
X-Gm-Gg: AZuq6aJxxBQ8xWH3+8zttpGBtbaR8MWjxDPRi/fZUP4cDeSV2CyKZLRC3IvicKD6IB4
 8JvF1ipXDSKcRQs6r+kh+9qJ7UKVxoxnxwXwGCyFJpTGER7v9kHzMULPxcOMAfaNdZRg7a+pXXt
 wKGhyf7q1OPwwOzQoxvybJ4gEWuQNqV8NG99SiSvjPCilSVLZTpA97Ku4w3w/TXW22shVqVQq8J
 VESX0qVop6b0BmYbV2m+nqkiEvweNr5p7/umHGFgA6uLzLuQ1Nhb2PrvQDa0sGJGqkegA==
X-Received: by 2002:a05:6512:2243:b0:59e:656d:2974 with SMTP id
 2adb3069b0e04-59f6cffb5d1mr2600517e87.21.1771260749071; 
 Mon, 16 Feb 2026 08:52:29 -0800 (PST)
X-Received: by 2002:a05:6512:2243:b0:59e:656d:2974 with SMTP id
 2adb3069b0e04-59f6cffb5d1mr2600508e87.21.1771260748615; Mon, 16 Feb 2026
 08:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20251209085028.115203-4-rjarry@redhat.com>
 <20251209085028.115203-5-rjarry@redhat.com>
 <CALBAE1OMwTX=a5i56G_sPXicw=17ozvb4PBfak0ev2Ps3xwuGw@mail.gmail.com>
 <DETKJKSUL9XG.1CTKW09I3UWSB@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655C8@smartserver.smartshare.dk>
 <DETNTVDMT8U6.307XVRW7VTBIE@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655CA@smartserver.smartshare.dk>
 <DETP2Q0QF39V.1KWT5Y2P9RLD4@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655CB@smartserver.smartshare.dk>
 <DETRNKI1EOKX.1GQT599JGQR7E@redhat.com>
In-Reply-To: <DETRNKI1EOKX.1GQT599JGQR7E@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Feb 2026 17:52:15 +0100
X-Gm-Features: AaiRm53Fussx_Ho_Yg8k_t9SQnmyx8qoBez_IoY93qBNLmfn6MM5aYHPNouZUNA
Message-ID: <CAJFAV8x+td-T3LswKBoN6+vC1aYXAaJVZJZvRYtwkTHCwi=gaQ@mail.gmail.com>
Subject: Re: [PATCH dpdk 1/2] graph: always count objects and calls
To: Robin Jarry <rjarry@redhat.com>
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Jerin Jacob <jerinjacobk@gmail.com>, dev@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KLUaDotHHTLZQLOeFh1sUlPCMc82JCwztrtaSeBYHcw_1771260749
X-Mimecast-Originator: redhat.com
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

On Tue, 9 Dec 2025 at 15:47, Robin Jarry <rjarry@redhat.com> wrote:
>
> Morten Br=C3=B8rup, Dec 09, 2025 at 14:45:
> > Sorry about not being more clear. I meant: "Then, if
> > [RTE_LIBRTE_GRAPH_STATS is] enabled [at build time], the total_cycles
> > stats can be controlled by rte_graph_cycle_stats_enable()."
> >
> > I proposed that you add your rte_graph_cycle_stats_enable() to control
> > the total_cycles stats, and leave RTE_LIBRTE_GRAPH_STATS as it is now
> > (i.e. to be able to disable all stats at build time).
>
> OK I see what you mean. I will include these changes in a v2.

Is this series still relevant?
I see no v2.



--=20
David Marchand

