Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F48CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 07:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DA8040272;
	Tue, 13 Oct 2026 09:43:06 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id E014D400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 09:43:04 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 488A41D000B0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 03:43:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 13 Oct 2026 03:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791877383;
 x=1791963783; bh=6W8wo+GVYYZwMo+TfIzwH4BKBul6acxc8Dwmfi6LLmo=; b=
 jSDV1OIizsa/oe9/k2FEf2Ycvggi7AwEIdnN6b5fion4YLC2pTapZzgBGxN4mwJ5
 GpDTz/Iw1IcJmNh9PJy+8qqeCgG0RVpx7gluKv2NQnlMwf52I3Vx6DsRa6U/sHzL
 TieZxbF8F5ru8beU3ZqAYO1FPXmvU8C6lnq61Ldyq1Qr11igRmtVdfTKSKDR8doZ
 I0Zr6KffJJiHfetbRASS2axDyYXAWlgWxhqoRXQl7pN2a/fttRIo6OlNfh1Vndkw
 mrdw9CYfZfU+WZdVSEpf0XBG8ja8mpgtd+mbx2Btz3/i4qRB0gottoXpuhmVEZXo
 YEVWrc4vXCosvgc61YZT2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791877383; x=
 1791963783; bh=6W8wo+GVYYZwMo+TfIzwH4BKBul6acxc8Dwmfi6LLmo=; b=W
 7qnjvzLAPNTiu//kuFf6hGcP9asScz7zhiTtiCoX7Ji8dmWCYpeNalBFf7WqZ5vV
 PT1lF3Um7IOYuZkQVlGDp8EHfMXnSTzCAOYXRtKn9+o5G+tY/PFp70vjm5HO5RcJ
 NuAaBxDJp8OB+bHoNsOFQxKc/X0qUobT0w/qdNVts+RnLWFTIhz6Bcm1qIul3w+S
 d/AKzRyTdlkmTtjYMxHI3u8N1g43myk7oUhzozNtC5Bi8q6enIhBhVJVifgOXi6a
 xhzMcO1O6QkVx14Qck7aNQsnIXu9XOl69xAt6Cqp1hFHRSHgfV0CxaC7TpV11R87
 YA/JuSwZt+bGnlR5B94ig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791877383; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:WasXtwfOunNCUlPgLdzt6kWZHeBiiKgCt2BN5WXssYvkC1C
 EGDBe8C7e/vh5Ozg2kKzBKPncvivqAnIFuB8TDDkTzKbm15/n8CvCHabAxR40onL
 eG2FSRd4J06ZBjfuNMDYNL1h96Emmjk+JJaCZT32E8MSBFZy9k30zP0cJW8Mq4sX
 kq/BTqwrEkynx+H/Drx/xBM/00YlGd2mhqHKANFb8PV/Lnc5dBcMb+68o2TK7aGb
 Iu1eHYZ9mgfYB7YPdY/JQmbgx0GTliD2TQGxKspmMp2PMB78687BZfw8T/VM8KBZ
 OFVGm66pAschAg3klKMKOd8BzqvkPHUJvzBkOfA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:zZTFdAEyp8Rk0Aizokew/6eRoXRxQ6RVn0pVteDU/4I=:Xl4UR7WHYlaMDPUHZ6umj3K3XvDUXP7Xag8XfxIuPgo=;
X-ME-Sender: <xms:BuHNajvinE923Cg31C81wAqczWdSVXxbY1q6jFlAQ2fBqBKF4WtEIw>
 <xme:BuHNataubZWEmm-QqkNizdow3yQLo3y_hYkaXMnPfNwiXAe5L2O80WXRLo48TdyBh
 C0-8W7d8uV0Y1IlT4yNlgKALcWyd9ok1sqC3ouE7UOvFPnkpuw5xS8>
X-ME-Received: <xmr:BuHNaiX9SELyRMQqUSISZ6c0mafmSIUXzvPJpuoRIRe1cKrZTvFHXBc5NwgHEqmjYuD8hnRqRkr5q_HQnPN7apw>
X-ME-Proxy-Cause: dmFkZTFk/I0l7du85TqY4osesoFvrbtKAWCQrARYESNYQkBu5f5U9WsD9+vUEL1hjbgnFp
 LfE2XGtiwV4NJ1ZRVMkpXeRYWnvRauYXnVFyIS+X0YMa7dLlWIS+GaTwN32NOCLaEul1Ng
 2A2RXKtv8kiOdHmD68ewDXKigYBtj7jEmMfdBsNTgAA2aTGkKY0tZCQCn8CtQ+B5/u0yVI
 nIT34XtPeTroz9S40/VHwQ45dsoiQqSs9cG8n+ty4ODV99EPayDC4dbj/ip4CJ7U51WYon
 6hPhBeJ6eFjudiwKQ6VGWkAOLupTMTtsefAMYDSi4kqlPayItGbl6OH0x/XZg7IF2wTyN3
 p9DdK1TZDWvNnjo2XPwnk5H+9Y6MHsNrDowgLnMp9Rat3zXYNqisfeUMpFwsqygPD4szyE
 NIQZRrsk+ZtGQEvjh8sj9DDZmJO5RfZspo/ysuDQYx/tL3O78+0rl4IjkA7N7j5gquQtew
 gVPDEPNRuCOOMZTDzo8Xd6wCcXd4oGq4fnY9q0ieKWnC86DdUd1eirwUGveGaR5qteAk2A
 Ck/aaR3RybPlTd6s4gH7ZBL8bgx3+h21p3YQwUxrHFjWCHf5GScn855Qgs8aDW/v2lDqag
 xJdpgqV+DXbxDxDxxeNW+SpWmsU1tgc6QuvfF0jBm6K5rVNFEOwQUQqZselw
X-ME-Proxy: <xmx:BuHNaiRIEDiUxXh_qWp8YHIQZ6EXS0nVcAkJ_JdBqwF_YX48YZPQcg>
 <xmx:BuHNagNqsoEaLAKrFoi8Nly3i4xhmCFqrb8ifwcmmV7isCkfXZbEKg>
 <xmx:BuHNagRF57zEZdxfAEiHXEgjoTeZJnQyScmzyr0pXo4amD0zOt-iSA>
 <xmx:BuHNaujJn7S2Uplgb9_gkMNwecwfxAIG8esC7jAJ8AD4WItliIVkFg>
 <xmx:B-HNas62sw8ERx79s-7dGagffAMDvO-DjuXnlt15d36rIXEEcCyUj0g5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:43:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, konstantin.ananyev@huawei.com
Subject: Re: [PATCH 0/6] mempool: cleanup, fixes,
 improvements and optimizations
Date: Tue, 13 Oct 2026 09:43:00 +0200
Message-ID: <IKcyWteKSGGiG13dgZJgmw@monjalon.net>
In-Reply-To: <20260910103613.808038-1-mb@smartsharesystems.com>
References: <20260910103613.808038-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

> Morten Br=C3=B8rup (6):
>   mempool: fix private data area size alignment
>   net/sxe2: do not use deprecated mempool cache field
>   mempool: remove deprecated cache flush threshold field
>   mempool: various cleanups
>   mempool: optimize access to private data
>   mempool: no cache size limit

Applied, thanks.



