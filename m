Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B9CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:09:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2F7F40150;
	Mon, 22 Jun 2026 13:09:40 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 041BB4003C
 for <dev@dpdk.org>; Mon, 22 Jun 2026 13:09:38 +0200 (CEST)
X-QQ-mid: Yeas4t1782126573t811t39089
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.204.248.247])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 12923415341800285576
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260617081309.19124-1-zaiyuwang@trustnetic.com>	<20260617081309.19124-13-zaiyuwang@trustnetic.com>
 <20260617085355.0a87d7ee@phoenix.local>
In-Reply-To: <20260617085355.0a87d7ee@phoenix.local>
Subject: RE: [PATCH v8 12/21] net/txgbe: fix link stability for 25G NIC
Date: Mon, 22 Jun 2026 19:09:32 +0800
Message-ID: <006c01dd0237$9a737e60$cf5a7b20$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwEDHC/7AhwDFsMB1WhqkbV2kTTg
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M4IGCaTLe0Qd6x15cNSJDO7o3+/UwEJyyE4cOox4qUIyLEgR4AaVRBlS
 1axkUpnqonk5wA9WoENN2N4GoBOUdAivxuahDhebzWsRmYMAfi7UpPfUDNO+wctt9s7+6X8
 fJ9BAoz6iQthy1gfBl+0XOUHcxS9FJ4LOM++cVE7X+aghNsYLHOFJ+M1s3EgLonkALmNgs6
 dOjEzJfVJUUWORS7Gy6azYmTsZ59jHCDBgW/ThyNqsFxZMKexcQ6tPhcdCmXiKPHgTMbhbq
 h/Al8pSftUaIfAFjwzHz3Qkj5eQOIlP0Sg99jesEVMAJm888jrsBeo3ApiOHknxMjrL2ncD
 DuhxYWOBDgsQESyJ+ArfCWk9QHR/JSvbB2Kati9D4mMloKKXS+I1k7gGQhBSKhEQLZkIoH+
 9MN1GfEhqT+HUkZBqWHrPXJHS62CNO11BmPxusZDDD/Yg8+cu664LTCv85s6y/uG5LYlXXZ
 6ypqRjFFRF2uXPCXUxK7vcR/jtugrXc0vSdL3zoamU/sjjHT1F56G7DQkB2RcojMaF9lP6I
 AwMtZvMD7wnFLD3BWiyOoX6YSQvCHmkqkEU7+24nUAOpt+36hxBD92/oySExh3IDhiFuiWl
 2zTRE4b/Zis97GfODhtIWnVyaP4eDJsh4BiQRpJkeZyhpNc8coXLaIEBbRELImprkggu6e3
 Oi2rzNYLbCTXUukCdqZuh5J1IM5989iTrb5mSddpVvAxUqywtkbGFFILf5MQxu2Cv3vB74g
 8a5bvFph+2KYGDwfB1l2/R+J4PGyfDBDaciy3CR+Ar6scYO/SLQusNzvpk/J09axNOgaQH4
 Tbk0vb/zlDYTG4JMlS91gxMG0cxS8qfWpsKHz5WQ2tvx3Pf42XvX4VTvo6HtJyyvZ9d49NK
 hE8clbb2NpbiuyE/8mur2trT1lQep6Njhd2DW9guLA2hbiiGldGGpuaOGYFX4fOodrqatnz
 42gqmouODQIhkMzSu0jcDABKmTm/9Yomcv0AyoMMxKTiYbMb3Kiem5B3Q53uYooYepj3Yyl
 vgs9TXA34cspOOsqa+5MlX1010qvs=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
> Sent: Wednesday, June 17, 2026 11:54 PM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Jiawen Wu <jiawenwu@trustnetic.com>; dev@dpdk.org;
> stable@dpdk.org; Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: Re: [PATCH v8 12/21] net/txgbe: fix link stability for 25G NIC
> 
> On Wed, 17 Jun 2026 16:12:59 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > +void
> > +set_fields_e56(unsigned int *src_data, unsigned int bit_high,
> > +	       unsigned int bit_low, unsigned int set_value) {
> 
> Function could be static here?

Hi Stephen,
Thanks for your time. This function is used in both txgbe_e56.c (for general PHY
configuration) and txgbe_e56_bp.c (for backplane mode configuration). Therefore, making it
static would not be feasible?
I have also fixed the other issues you pointed out, including the spelling corrections,
replacing tabs with spaces in log messages, and removing the term "master" from comments.

Best regards,
Zaiyu

