Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D34C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 14:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DA39402A7;
	Sun, 12 Jul 2026 16:24:15 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id D71D74013F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 16:24:13 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 0A2EEEC00AE;
 Sun, 12 Jul 2026 10:24:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sun, 12 Jul 2026 10:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783866253;
 x=1783952653; bh=9jeLqufrehSy8dlk+pTLG3hyi9YZcr7Qy3QURALm6uM=; b=
 ivTCNxzmF8oTJkCtZndbhRVcAUkuYxtcZwrTkG4SAWlio+niSkvvLv1q16NweJOK
 toLQzw2qbvAbimImP8oJXy50zaN5vfYP8jw913S1UGb4P+9AIq5YhrumRJgprjud
 77gXWjsLkd+emIHQ1SG5irMDBn1MhQI48I9wCkHb09wNbYc5Wjg7p6podpiIpACh
 51WKwW36SqZig4ye2LalnITWbOBEZTtGnuXRqz42BO5TaXMbcAfuXNcr0peD79Jb
 gUwnVidZvq6icnZHhA3aTAb6Hd2i9sfG8Z/8NpP6LCklde0c4NxTq9XzB3v1/L+/
 m1WUNhfxueYkda9Wh4TiEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783866253; x=
 1783952653; bh=9jeLqufrehSy8dlk+pTLG3hyi9YZcr7Qy3QURALm6uM=; b=R
 1kycdVl6KFc05aWg/7Gyi8250RKKjO+NyV3Jk91To0ZVuwFpQMwrdcCroLYJtJVw
 L02IDM9+IjlxZOOQ1djPSCIrz2q6rA5JTfu/qm0uJcSF1KlClBjD7hJ6+U0VDyQ9
 OkzZSx2lRBZhtEx0cBy9u7AR/ydnMpDEze7SmHvrpDGlDsn8UEkL0/52mNyYVtLZ
 QeDLzSr9JUEm0O9LNZUbDvM2sqiHtRuJ6teID5okHzh75QQ+YIXtGI5hVjO1zQiE
 tzhwmBehegoS3fjx1rmqaaiDXtxtMSQMDaakbAc3V+f3N6nvskXWUxV+WwPV+oHk
 rcsssXZy2nX4Eml4IwyYw==
X-ME-Sender: <xms:jKNTau8ZzBZZGXbRLIPK3-da6VpOvXNRBUCIGTkZ_ZoLAtQ61Tzoxg>
 <xme:jKNTajCwH9z1weyw9VSp9f5WmdAPhjeDEgmjqPVD1DgrJzBFMWQCvdnqK6W_467mb
 FLa4leo9xZKSmiz535ERZIJRKZoD9OWAKw5vNZrK8Dw8B9_JjrlZuM>
X-ME-Received: <xmr:jKNTajLXnRkrFQIuJKFWxcS5L6wfIUDIRQ2Mf3f6eLNC1PgHzCPl9gaGi6RohWIwdYaIKiavvvZMRN1tiEGWkRE>
X-ME-Proxy-Cause: dmFkZTGTnVHR30nhKnJjayD5Zb++4TU6B47FYchCjenvSPcsew5i/1W3i/gAkcP2rz+KFi
 ZXrBT5Q+sYTmSnq3UyaRnCWD5rg55zLdl21lqMdioR0kN0b+C09r4sPrl91JGuTPMeQjXJ
 jAWaLh4Nmeo6MqSIDp+nqaVS/s0V6ILSvVzGKdj0WrpcEp4H1aWS9eMzpTLc6iQJ1xTAtm
 6AB94CJ7LZuHCUH/mHhu8BchN8jjGRU553M77Ek7hQXjgLqQnsJRFLHR96D7QoH13eVF/1
 VPKqHimvoamJm3BUi6k9SY8u2uZseRlUTxm7C2kNrXuK+UQivwLfXUz6vjD92VF8HOEFRn
 LJesWAJXpNvXTWrBPbZiEW/w8DUuZX/X+l5QayPINb3AKcNpvRoyBzp3hvjrBUwAxdsAQl
 2+G3sL54thqATGnhTXY7d1AUjGrIq3LxI9VS6O+WuEmAdwN8nTiEJzmVycx4eLZ2y4Qxfw
 JI2k4YlsQupBIib2HsfGx2r0J2x99qu8nuh9Hq5aE1IoxnofU2jfQBtw014Si5Ebri4T0l
 UGDVja8L8tWW7QiHa0TBka46kdojjPnMTLVMq457Mo2NMOLOxpuqO9Gf0U6/5A1WhdxIhM
 fuRy8VXGxbEfTH6LQnAmPC9RPLRI5EZwuCeC3zERNUv8WkVZXZ55G1Id21fw
X-ME-Proxy: <xmx:jKNTaumDdSd8mlJb1X7fAcCNoQqwIt9zenr56rRkruPSAJKdXUrH2A>
 <xmx:jKNTapGI1j7oXEapQggaag4fmAdPmVKzcOvpXU3rdiMdmSlKwPkuhA>
 <xmx:jKNTamHvgAy6Xd44Qrf18EhiGYUwKSXGZcTOeBPURbP5TI4KoRgOBQ>
 <xmx:jKNTauONxF8Z_zy5GYOgmULDIOiwkmdTf94Zs_vuM7tWYZzuW9uVeQ>
 <xmx:jaNTas1G893nTkQvqrRhgseIQW7MPoR5MEoi92YpKrvdLlCt48LoQjyO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 10:24:11 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH v3 0/3] extend interactive telemetry script
Date: Sun, 12 Jul 2026 16:23:20 +0200
Message-ID: <BSSbSEDUSNqoEdkkNP7V7w@monjalon.net>
In-Reply-To: <97afe9be-41c0-44da-b144-0fddeb7374e5@huawei.com>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
 <20260609161400.3661268-1-bruce.richardson@intel.com>
 <97afe9be-41c0-44da-b144-0fddeb7374e5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

> > Bruce Richardson (3):
> >   usertools/telemetry: add a FOREACH command
> >   usertools/telemetry: support using aliases for long commands
> >   usertools/telemetry: add help support
> 
> Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.


