Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCFFC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 09:29:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32860402D1;
	Mon, 17 Mar 2025 10:29:44 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by mails.dpdk.org (Postfix) with ESMTP id B9C0240261;
 Sun, 16 Mar 2025 16:00:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1742137235; x=1742742035; i=markus.elfring@web.de;
 bh=MX7eil2W30IflRHJeN4jv2StG3ClXZPw0LpQh47Akvg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=W+gdNuuBgASrYQo4t2PGNAl4H//83TzVOtQAJTWAoPaD1RVblvT/jeyECMbV8aYv
 lx/+NhxwzGBCjjVCJUwzXNwx4plV9jESFYccDMsOnNPhNhTe2UXAThwwAJQtIEK/H
 vauDGCgg2a2X6U0vVUw2DrSvGy6RcrtsPHIXOfyWV/9Ani7HoaVojcVg6NZHVyvkq
 RRNkGd1zAspzBG2XV92QXsVx60UUTXuZMcloxLB4AOtQXl2GUTSfpXXh0I36WR2Vp
 4FOKfLupDyLtWb03JLteDNXy3fn2PgtzAKRkJroA6GVmeyWNGL0UXIdySFKcGCOJQ
 kOoLvjpA2jC1+WzGYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.60]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mcpqo-1tJwQb1Nbu-00d7xZ; Sun, 16
 Mar 2025 16:00:35 +0100
Message-ID: <091fba98-8d3a-46fd-ae99-abe9be5cef4c@web.de>
Date: Sun, 16 Mar 2025 16:00:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: stable@dpdk.org, LKML <linux-kernel@vger.kernel.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>
References: <20250313172307.274109-3-stephen@networkplumber.org>
Subject: Re: [PATCH 2/2] bus/fslmc: fix use after free
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250313172307.274109-3-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3eRzxa1gplmn1bHjpozKpQrJ2XBzZ0xWG4Yga4KNr7GzEuPc+Cl
 p3FVxpGGmETeqbg+6RTNZdR6p0g62LrZ6MmOCxsiJu7mLCKGiHAXwufeO6BhfGNCu/LP9b9
 eHqfNhgyYmoH+w0W76+k8LWLkHRVs8/HCPSEDvrJJtJgmkgQtm78r9XAk7b8kPHhSLkccNs
 G2MCI3UvAStUpBnjWgGaQ==
UI-OutboundReport: notjunk:1;M01:P0:Hw3emMuw9FE=;053xSPl1NAXfujwKm7A3e6v4SSt
 OZ9PaA1TvdOc8iv3itH/J8Ilmu911VZu+B5X7z+4xobHAj1XPBNt79V6c0cMGQuG4M0EeQKwd
 /0T6VzF5XO7keaBktHYBRbcftqt2XSRxEgQ9vvYeb29kB/Q3FXQ6poU9Poa8+BhuH0KZVnDkx
 vfhgdfsnO3hv4yym/RTeOBU7Q4KSD4svGPlPE5vtDSFyvrDAZ7iMoYez4yH1e02PtUJihs0L5
 qRZsPT3HJ+5YJsKT75kQF5Y7uMToFEfSuSRskIjZ0k5/g4F6Co7ScO5R4ojQ7j9goflTxHafQ
 NpipHsoBje1+zhtDsn/I/VP2pQg+9ELUVX2zEYiBl9/4J/IZaUqgPX/SzWvf8EBSNCYGdE1vO
 MoP5i4LlVdEAwM8tXlqP2Czm+lL4Jkmu88ajmo0nVEjtUK6N6W64hDUWVjo0yGKFeK0qUaLkw
 JQx38qzdn0O/78UKcQoRZH95r//0gscr6zH5z85WGdhZPzZpc2nD4xcCiki20j8RrEwjxT9q8
 0ITTEQKXsXS7/4SqNPxZNags8PsHKc3N/k8+1gXC8WD2BwW9c0y4BXp7Og1AEZIcxpl0XGMPd
 prFdyWPosoyj3nGSrk6Hv5d1FxXxlWefaA9/verR7EHIeb8iDDUCZXN6bBHFF7pdmU3I8Cj2K
 J23r06odwmuzBdfUpeD+U9LCBLVcno/7ENAwqYGu5R+k58LfozUidv10VtDdHvqRZczQBko8e
 UnTTQ10qg/7qTWSG4KGzN3U+L5tNZrNtUdAmxFL0Wpes9XC+TwUtXZxQJC/QlYbMMrh2jD2MB
 dWkTLB97iAV2fQuqtkyIYfNaC2QQG3RqwGyrKrLOg3ckX9ZG4WxRqnyPU8iwpEvIYJ8Ek8hXE
 OAm4BM5tp8OG7P3S23XcSktiwKhEFoH2OGoJ2jrRjjs49yyCWiiaXaiRwB47r9YArz7S3WeYG
 AhoE2a+iYTfO2WFaDb5SeLjUpU4KbrOKwmLmte169Gdf1iP/WC3WHTz5nZq7TnASebxX/i7xP
 amxEPs1KjCo+ODpLV5MUmBZesvp4qo3JNye3xFykMxEUwgRVZCuogpdv3fQCkFkMqJeAVxhiW
 gQpj5APil0+du7VSPwWSEZ90KN8dFe0h4fb/9O1DLM9EupDzfoCJOJSJ/yJsjWvnJA8XekWwd
 Qr+JmFp+4ywQp87hD4F96Dc8k3rMhhX/vJYNwVgv7F6AHUnIKDtg6y320zX7nmIe9JDCbLON2
 sqiV3wluocvU0USNklK1B1OpSkT6g43uPjD4yoatzblyRcSY75LIyHqnnj8A2ujB5W6hNWjvD
 GmT+h8ljXTklnn53IHM4RXkqhQn+gJCko8A4CAnPgTaUUFF2u//KwimC47+iWkhmNfGCRhLwS
 eA0KmCPRyKzbzr+8JNH5S1zyjJ8+8Bal6TAZp00mT1/iA2NCg/Kg/NTVxUXMc7x5yknzzwOJd
 XqEyrWlbWxnk5wR+M96v8g4JbxebLfB8pIc0XpFaMlQ24dmhEjpZkzp+OngbR+JwnILvIVA==
X-Mailman-Approved-At: Mon, 17 Mar 2025 10:29:42 +0100
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

> The cleanup loop would deference the dpio_dev after freeing.
=E2=80=A6
                         dereference?

Regards,
Markus
