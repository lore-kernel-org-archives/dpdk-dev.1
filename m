Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9A5CD4F54
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 06:57:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E549C40296;
	Tue, 19 May 2026 08:57:11 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id BD90A4021E
 for <dev@dpdk.org>; Tue, 19 May 2026 08:57:09 +0200 (CEST)
X-QQ-mid: Yeas7t1779173821t115t36075
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.196.16.37])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 15632586834143366184
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>
 <20260518075422.4d1adf2f@phoenix.local>
In-Reply-To: <20260518075422.4d1adf2f@phoenix.local>
Subject: RE: [PATCH v4 00/20] Wangxun Fixes
Date: Tue, 19 May 2026 14:56:59 +0800
Message-ID: <006501dce75c$b0b01710$12104530$@trustnetic.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0066_01DCE79F.BED5EF20"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAkVeIxS1SILpQA==
Content-Language: zh-cn
X-MS-TNEF-Correlator: 00000000ED7A7DC852FF08438ECCC3C27ED7187F0700C3B68E10F77511CEB4CD00AA00BBB6E600000000000D0000D0A3F95AF43F1D458BD704A2B671A3BD000000000CFD0000
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NHGFjaVOIMm2Cp0M3ZrlfpF+F9w3Wa/eXNmiTC/hGd5guFpLywvBpCE/
 d+9LARLmS4srVTGjWQFGxaxeEJyTITtqwRq7uSQ38m3zmDbVJShIsF6qMuMIQ5FOXtlexuX
 4dc7KF/hFBG3kJuQVtXrvsUVjamFyT9QkV2yY5Z/wHQHkGrFtWIkfSm3OGX3Uz3iRG0aGRc
 adoZIpDMSp9jGBlallIoKHf6e1y/j5FsBeK3AW3rn+uT8laZaxOIIOg5dyz2+0HdUveHJEk
 elUnbYHQ++FoXFgVLDNsHfR4YA7B3c1//iwWsSdqU1tvq2YCgr9BXSWdfIVqp4X48E9PX5i
 klPbjRHTHr7DCrUQJv+bUUpN5d1XzhW/eWIx04j+/bhy9+AftpMzV7OKMgYQmTCV0Fc5UDj
 L1tjadj4Fv4Ol3Ljykt8OxjbL6lgxyycHC4MRXO6mt69cpmFDzfqUx9EDK2WirIkobAVkC8
 VqzMBX+Qe8U+u2qaC9NXsZxC1JxKJ/xROP3zFG35YMkc2pNzHYJl3TvU6RD5dwwbr0e9Dlc
 kGkpzKV7CYrmaLJva4ZwEH38Lm1hUX4KSyZqQ/iA4N6AZ1kHURPkC1wlDhyEIk+BDmTiJ2/
 /BsLPrksCxvhaKgdiS60P5/bAt8VVvZbGT/tEMKF8YhnpRKV4JWhDrFdADh5WOh9UUf9fZb
 2FSGPteDxwLI2/ihVh1KA1T3pbVkPX7Z72MXkTEKR3Apahr9wDY7ly60mu7A4ibmjZBzksD
 Ew77OH+Zauga0azyAC2uvgVJb2Zb8iRISgb+zpQkVR2b8QDq3hpW90lEQGKWtmn4aDd2DAl
 nO7Y+KffNVl6v/W+YIRqvwOyKRQevUpMWH9iiRU4LkugeQ2k2KuuX+cY06zB0wlMNw9hNpZ
 RkBkMmTCdArS8By4qCAxw4Li2yZNNP3YDbrvRoxOksgagRxvqcA7JvTp6Ax8T1lAfscicwD
 rgJXrbSZXZZR2K3FsoiVlPbRO12WyM8hFE8fEXuh5o5k0M4UdgVo6RZ+4eQB0aD7rvLrOf4
 klFGg+1AdhomXo0d+W
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
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

This is a multipart message in MIME format.

------=_NextPart_000_0066_01DCE79F.BED5EF20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, May 18, 2026 10:54 PM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang
> <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; dev@dpdk.org
> Subject: Re: [PATCH v4 00/20] Wangxun Fixes
> 
> On Mon, 11 May 2026 18:35:42 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > This series fixes several issues found on Wangxun Emerald, Sapphire
> > and Amber-lite NICs, with a focus on link-related problems.
> > ---
> 
> Since these are fixes, they mostly standalone.
> If you want I can cherrypick the ones that review cleanly; and you can
then
> address the ones that have review feedback.
> 
Hi Stephen,
Thank you so much for the detailed review and the very helpful feedback.
Regarding your suggestion to cherry-pick the clean patches - if it's not too
much trouble for you, that would be a great help.
Our company is currently evaluating AI-based tools. Next time I submit
patches, I might be able to run them through our AI review first. That
should help catch issues like these earlier and hopefully reduce your review
burden.

------=_NextPart_000_0066_01DCE79F.BED5EF20
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
rTthZCWQBhBwIaBpGUAXOWgAcDxQQSPCLWxpYw6wB7BJQ3MlkAPwdHZoPsA8AWMpQDxiP3BuvGst
GUALYA6wPFBwA2DzAmAiAHMuOWggaSRXC4D+Yz+gQEAHkD+gCsA/oDrD3yWQRLEl0ARgIqBsJdAi
oBc+0QdAAiBlQndJZiAeeQhgOHAAcAVASSBjRwOREWAEkHJ5cA3ga19EojxhB5FAQEGgIBlAdvsI
kAfgY0IwAHBGUCoQPtIfR+JIkkSxC5AehWFkZL8ZQAQRSYwRcDtASlZmCeCcZGIA0C4gMoxIaSFm
PiweFDoAAHBJYEfic2//RgAb8EBQAhAFwEmCAQABkP8DEEHBSmU+0kmCO0El0CGwcGxwZnUDIE8N
MGBn3wsRIjFH0gXAO8BnICAioNppPHF0UjBI1C1JN0rTj0HgQaBI0QQhJzk3O5DXR8A/gFoRMgQg
bjigV/H/UjUpIAhgQiFSk0fhRaJKMf8jUFVAPFAj0EBhCcFOElUB3UJ1T1chKdEKsG4l0A9Rv0Cw
SQAk4UZRLcAHQHVBoPFWwkFJLU9AEaBUQVtg/mxCYAexDtEpkAeASGE7wH5iIiAFQFmVJZBIcCIg
Z35oBUBdolwiWAEpMEwDbf9EoVvxZEA8YFchYUBOhz4AzyKgYiBRgQVAc2hdU1Tyb0iBWbE7lj9w
a0SWSvBy7z9wE6E+0mfwcAEQVUBGUd8ZQRvwP6BXA0plYghwAQAKbkJ1fW2QAAAAAwANNP0/rQ4D
AA80/T+tDgIBFDQBAAAAEAAAAOkv63WWUESGg7h95SKqSUgCAeJlAQAAABQAAADYEgX57kToSp7f
LthgKFklAAQZMQIB42UBAAAAFQAAABTYEgX57kToSp7fLthgKFklAAQZMQAAAAIBfwABAAAAjQAA
ADAwMDAwMDAwRUQ3QTdEQzg1MkZGMDg0MzhFQ0NDM0MyN0VENzE4N0YwNzAwQzNCNjhFMTBGNzc1
MTFDRUI0Q0QwMEFBMDBCQkI2RTYwMDAwMDAwMDAwMEQwMDAwRDBBM0Y5NUFGNDNGMUQ0NThCRDcw
NEEyQjY3MUEzQkQwMDAwMDAwMDBDRkQwMDAwAAAAAAMABhBoWcnhAwAHEIcDAAADABAQAQAAAAMA
ERABAAAAHgAIEAEAAABlAAAALS0tLS1PUklHSU5BTE1FU1NBR0UtLS0tLUZST006U1RFUEhFTkhF
TU1JTkdFUjxTVEVQSEVOQE5FVFdPUktQTFVNQkVST1JHU0VOVDpNT05EQVksTUFZMTgsMjAyNjEw
OjU0UAAAAAAWow==

------=_NextPart_000_0066_01DCE79F.BED5EF20--

