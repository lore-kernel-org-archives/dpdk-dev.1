Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4074BCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:21:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C941041132;
	Tue, 29 Sep 2026 13:21:48 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id C6E43410FB
 for <dev@dpdk.org>; Tue, 29 Sep 2026 13:21:46 +0200 (CEST)
X-QQ-mid: ivesync10t1790680900t4d008fe4
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.227.112.38])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 13754035785338777318
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<dev@dpdk.org>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>	<D88DBAEE6DF34BF1+20260922125414.3638-1-zaiyuwang@trustnetic.com>
 <20260922063519.6cebed39@phoenix.local>
In-Reply-To: <20260922063519.6cebed39@phoenix.local>
Subject: RE: [PATCH v4 00/16] Wangxun fixes and new features
Date: Tue, 29 Sep 2026 19:21:39 +0800
Message-ID: <007001dd5004$b27423f0$175c6bd0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJQoSGLe6Ko7JYK43S1iCPo4FlmCQFIRi0IAq0I1V613xwv4A==
X-QQ-SENDSIZE: 520
Feedback-ID: ivesync:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Oetrc8rcdWtPa8fFuzpDaB+oMjiHfmH1Q94xjoOgbxoG98T5+WwxlFaS
 9QrB1C8n/pbOFy41I1yVejuWxL6u0brbcl9j+yuiMiZiN+qp7ylWL+Ki1qr4y9K4o3J3P74
 aul7TFzAWYBYyIGwndz4E6X8jvE7B+Rpw0RxNjz3v2Hc6xxT/PkjqERBU8wKLHdCZK/+O0x
 HWkCiim9sjhmNg+VQ9tv7FkqIbTqn8AbxSkd8gtF5pbTHiZozfWDZiuIMOCtPcA6tt/r4/y
 QIjYkkqLRqi5uLu+CZcWoEbddTMA06gp/JnfkxTiiFeIq35mimdqebeXTFCUowxXGKj3jhs
 DlZ26UcP0onGJ6jTsXrqzoGivijrpn2wYG/eCAIdlrvcR5RjN0KKVH1QUqXxj5y5WpfIjvH
 ogflh+iriENuUVkvvVCVzy6mN7t8yDU/QXZOgAituQNS1CCZbmzVi7UUZI11IDhOY5SHmfr
 UMXx1fu0womVMz+USy5WjUQtGaRI6Ku8tLELttUZ4/rNd45Ars3zTGvxE9I+XNQXz/kGHpj
 Cbqdb4Km46mFZIZsszJrwpGwP09sfbCsEKQDQ8nsjVoAolZqvl4QB28Rt5Od2qqIXt98Dsu
 7DzKtU8X/yaMzwfrRHytqi/2EUAotvDgg7pq5UVGw9h0tfQrnFTdTZzERyk+h1eKFP/tKLk
 l5daso4QRU9QG/49xPDYJcFaZjvXbWDjY8i38OykFCPI89scesakPc9E74vrrq6TXfsQMOM
 gYf6Aquurw0EP1mnFASdrv1afOz+PttGqttIj1XmieaLRGzhUbC8UbasQBOkw9Q5lxZNJBH
 muAZtaVWgy8JQQHO6BnpTFoQixOQd5JITDJj42BUP96tFQ76rlVbwczigbfDsmiqAUV5vRQ
 qZYA35xYZiY/P6SILXsqEFtkhat5RSQPRyV+0k/5qLJZuGY+dv6h4IhNUVDXurehylWmFDP
 xRV9bi8urMXl1VOoJlM9TwVHsDFoSvbfaTw1su6uuFEwXXmsqhvlqxFA4TMvYYOuyVtEetK
 iDU7GztInN1TIPYn5MSxTy5APfbguWl5KDzARQVKHhu54RwIyqOQqXtbMytZp2+yKV+R5DE
 nz8ZyrvKHkd
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, September 22, 2026 9:35 PM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; dev@dpdk.org
> Subject: Re: [PATCH v4 00/16] Wangxun fixes and new features
> 
> On Tue, 22 Sep 2026 20:37:33 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > This series addresses link-related issues on Wangxun Amber-lite
> > 25G/40G NICs (CR/KR training, hot-plug, 10G link state), and
> > additionally refines UDP offload handling.
> >
> > ---
> 
> These AI comments look like the need addressing
> 
> Review: [PATCH v4 00/16] net/txgbe: Amber-Lite link and offload fixes
> Author: Zaiyu Wang <zaiyuwang@trustnetic.com>
> 
> Series applies to main; every commit builds with -Dwerror=true.
> Fixes: hashes resolve except the one noted in 13/16.
> 
Hi Stephen,

Thank you for review. I have addressed these comments and sent v5 to the community.

Best regards,
Zaiyu

