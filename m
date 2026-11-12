Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADEB606A8BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=DijSDbIB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IV/rBDak
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4263940E36;
	Thu, 12 Nov 2026 13:46:05 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTPS id D4E5140682
 for <dev@dpdk.org>; Thu, 12 Nov 2026 13:46:03 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id BF154EC01BC
 for <dev@dpdk.org>; Thu, 12 Nov 2026 07:46:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 12 Nov 2026 07:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794487562;
 x=1794573962; bh=sz4JwfYr80mQcCEvg0sI2tcvvgUbeHI+bynz7H7lqfI=; b=
 DijSDbIBnXgjKZ2ki1nXYw7TeNqIpDqMg0H+sDdChGKd6lqN0RfBymFkf2SV2v4X
 grdX2gOeMlSU5ULz9WBF2T6qkNFf2gkEoBo19k23O3sZG/ViVMDEUPaaX/yfLraG
 jdWu4n8ItSrWcw9IfT0BcdLTpxBfFbzxizBx5G8TpfVCZ1rGrbL1fz+6FsSDhC/P
 moSVBeXSWhAI4DngALns3U0cDsPB/dbj8AKU/5F6Onj+hegu8kvQHB4Us0yBhcBD
 bVGdE4PMyzE13pKPO8il7O4X8qKYwnU/dNEZqR7tZ+j/ee+n9O/KUB34ZB/fHxny
 FDg40UtrETWXGrmQyqsOxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794487562; x=
 1794573962; bh=sz4JwfYr80mQcCEvg0sI2tcvvgUbeHI+bynz7H7lqfI=; b=I
 V/rBDakANkj9ipc8RWIVTvei+t4vFREdqrMeKEK19wOFRsD7dL6LxXUfbys8MQAC
 J0yVAT0PMxbDcfwtFXV4cRgZ6mW7H0u+mlC5mtvqpAfcPQx0/cQLX7WQvzoLhsLK
 30a68P4usb5x+hHEfPtqdYMtcF+wtgu0H25mF69yK4CDfL5M7h6CUQpWe1YrFdVu
 JqwOQr6t5aKv2au3JIl1+xgHVj7AGpEYOUbXz3EMtQQ3LXdnOt/a/a+ILvIbUwf+
 9kbYp14JrNmZfIJmxG3MkhVrEyp8IVzyL4usNuCoTeV8fWvtS+/UonZf2jdNjuni
 CgqEGswrNf1c6+oprpktA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794487562; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:0MhIAoXnXshFhLUwjhZiykluGcYOOQpEXIu+J1mO3oNBqdg
 AznAHF8fhhrlaxdfy8IjGvsm0KV4N4F4lvB3hdvaFoll2+3XQLf2vsOfWkkXX3mG
 KV/fTmLE71oiXy4PuG7ObnMzWiQsfYYVe+3QnHRwHiQkQy2YmGKnojPJ+2d+YuER
 QvNepPSDMJnmOh6YBYIQqbgEmYTXaEqVOjMQDIfZx0qgi4nwQjd6d5+DjbomuWbJ
 81aUtgRhR+PRcefBavNwxWdE5JLVPBr6pK2H9Gk/5aQr1j5JCIhgdV4pBvhP9WPy
 Niu5bJOTdfb368yrkj6XGEGwPa8IutpDeLVyMbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:1dzhlFf546UkFRUx6zuRmPOtDqJ/A5r75NtE1dU1qsc=:hiIyg0Jr9ddn37pBvapEjcB+OBAhEXWgvw32pZB6XLg=;
X-ME-Sender: <xms:CrX1ao08Fqz6298pO76p00NX0KPOu0D8f3B1TPOF14BIuFDt_7S2-g>
 <xme:CrX1ajP3a2KMe6SGwtkPLDZniJgxeFu_sEAJk8ri5RI6ZmxAKCsug2tnhvkhPFtrT
 RkZ2DoZZy4xIafI2dxY2sNOXE9svYaZhgdW9HBUjNoIUBjIy4vDzsc>
X-ME-Received: <xmr:CrX1ao0c53I6NR9ImeaGkZDXAC3wl6XjcmjIYDpwepPfa6bvuWSjUA3c7eWXi6go07L1T9N2B2hb_5l0d19coKs>
X-ME-Proxy-Cause: dmFkZTEp5a20HkjQ5u0fTyF/aViCO+L0+fib0yTtMLWwiEC3mXHt60L2Dv3X6JJr/6O9/K
 W2c71Wwil1eQlvuUfp8Ozcm82/Yq80d0NEOk0BTEKs/8k4A1cR/JFVGEKHmBnsGOxVDQXH
 nxhlD0HGtSey3q4AltMaKU0W8HIgPHL/yXsQjxpHx0o8BOYXsGWyiCeMWsHX8/KOMBQd0B
 C8k5zQwbAUbeG51k4GGUw9ZQTmoJ0wnReMI0C9Kjn49ETzAYaItJEj9ULdfnp2Z5B/cd5K
 I/32czuv5r8jeBGc5P2ujpP8NFRyEG8D+dCzO749XA1RcGKDNbU7SajxofJ4LEk/Ir6rH3
 golWF4fETAh45i77IZ2tCrnz7e17kTUAE7GdTwMzKHqa9jKwrT3xLAsLByhcVB4K3vx4mi
 Fru7vVFjuSLeHSXZ3UpLbXyNFqNyqr2QjYi0aOWRwQwRyZ4ghaq+Wwk/zoLNWRt6ts0oNp
 E1GiYIaRqNUED++XjK45+GZ74dfmXFuobaMPChx2FgBZ9xok6EFG1nEZvi/xLrPBHEehHc
 rgCMYo4MU0kpxcCa1eQeIAN7NBLCiylEic88XKlruqZGX9vfnGvhfXwTOhAxCVTLRaLoLJ
 BdaqvpatlIWOy5sGgLVahEiWI4/4DZPCE1ch6DFCrUoghhLLW88hLDRrUDnw
X-ME-Proxy: <xmx:CrX1aqGWOItcIsbUO-UA4poDsH8xRyqeIKwp5-WVVWcPWGXmj9GwyQ>
 <xmx:CrX1al7WwgYyV4rdUTcnxOFY1Hb1jK6Hb7MTM5VsgHl91F-3hA9tGw>
 <xmx:CrX1agvIVemON5tWQQGzznTstDilmA5ZPZQrzYCdTOiCYK63K8JTYA>
 <xmx:CrX1am5EpQzBeH2xNal6Xc0DXApmpECeUXuB9zALTx7f1_1Q0m5FMg>
 <xmx:CrX1am1Nzbjl7vdwotuMBhm1lWMPCEI8gQtq0KGS4C6yd0PocajuSih3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 07:46:01 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrey Mokrushin <a.mokrushin@ideco.ru>
Cc: dev@dpdk.org, Jiayu Hu <hujiayu.hu@foxmail.com>, stable@dpdk.org
Subject: Re: [PATCH v2] gro: fix returned packet count after UDP fragment merge
Date: Thu, 12 Nov 2026 13:45:59 +0100
Message-ID: <3fxp6cheTkWA4HW6d1qGRQ@monjalon.net>
In-Reply-To: <20261106080744.138763-1-a.mokrushin@ideco.ru>
References: <20261106080744.138763-1-a.mokrushin@ideco.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

06/11/2026 09:07, Andrey Mokrushin:
> rte_gro_reassemble_burst() decrements nb_after_gro only for packets that
> are merged while being inserted into the reassembly tables. When the
> tables are flushed at the end of the burst, gro_udp4_tbl_timeout_flush()
> and gro_vxlan_udp4_tbl_timeout_flush() call gro_udp4_merge_items(), which
> merges fragments that became adjacent only after an intermediate fragment
> arrived. Such merges are not reflected in nb_after_gro, but they are
> accounted for in the local index i, which after the flush holds the
> actual number of packets written to pkts[].
> 
> The function returns nb_after_gro regardless. When a flush-time merge
> happens, the caller is told there are more packets than were actually
> produced: the surplus pkts[] entries point to mbufs that are already
> chained into an earlier packet. Freeing the returned burst then frees
> those mbufs twice and corrupts the mempool, and the surplus entry, whose
> headers have been stripped by the merge, is handed back to the caller as
> a standalone packet built from fragment payload.
> 
> Return the actual packet count i instead. In the path where the flush
> block is skipped, i equals nb_pkts, which also equals nb_after_gro, so
> the non-merging case is unchanged.
> 
> Fixes: 74080d7dcf31 ("gro: support IPv6 for TCP")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>

Applied, thanks.


