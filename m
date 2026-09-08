Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7A9C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:43:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C86540E27;
	Tue,  8 Sep 2026 14:43:51 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id F320A402F0
 for <dev@dpdk.org>; Tue,  8 Sep 2026 14:43:49 +0200 (CEST)
X-QQ-mid: tivesync4t1788871424tf8970c4f
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [36.24.66.61])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 1464792515905311625
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260827131137.1daf141c@phoenix.local>
In-Reply-To: <20260827131137.1daf141c@phoenix.local>
Subject: RE: [PATCH 00/13] Wangxun fixes and new features
Date: Tue, 8 Sep 2026 20:43:43 +0800
Message-ID: <000a01dd3f8f$aeeb6ac0$0cc24040$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ8QNehdnXO5ExpIOsSsHb9Qgxp5wIt8ZkwtXUtajA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OOkIcXXGmR+088uukEKQge489H4aPOle8CTOl51TUaICVotoVuMkGehd
 M0L67KDd0nfEvW+Xetmq4DSiU2XDJ8G7D71Z4ub/sm7XElUE7qePd1ZCyt7tIVtffneFkxs
 KM6DF3eqYnj8a232Y4YqEpIFOYpeVBlXF0QR4ICNsQid/0Gk2K1G4+1o7eOi8dUFcHvamiO
 WweVRmOaX8UX/c893COPCeLp4jNQ2RhbvFIxURgg3hx7yj9wOBdUowWf5v1QsUSiGqV1C5R
 hDRA40Gs5+MdKJAxC4n6I/rkqVfZ64zya3lIVSoBPeIvX0kfmaX9LzCrm3IoDm05YttJvDY
 JF8CVBsORUuWwqo35miOqKnoA6CPBI2cq5pdn3QiKfaMdslCUSX75rNOIQSXnzZzkk+58SG
 AwZjn1RnTh3RXAfkgf7T7ac+1b7nmXn1y++cR8SZFJbTIP0FJPRcDFAXQ+woquJnVM8mgYS
 tPGaU+QrLfIh77TtRY5qsoCqgI4F/hMRUIsfi0S3wrusq4KFnkm6SyA+fKE+RTyECJQjauT
 k5kmZe/YJqwGyY+kLi6RIHTPxhRZWbBKnW8SbWqJmqb0siTwoEHfPfXmHmALh0d+Waioee0
 awbI9tHJjuph0mnK1xx0gZBPN6uvwxnXqtHYziSJ05xhWoKvkfaB3cVc0o4fKBZsMJNwNZX
 JBWxyrNkz+Y5Uqxohr0QYqsy6XkYuYGE3VxyY7zUin3pClL4qvfkyGjWkM72dnYFtjOxoJ1
 Kjf6Gbee70GBKyRckFUekI7KtdLCwoNa6zryfZeva7COBcYrHUANi+yWL9c0AeTPoV6HsOD
 rYBqcwryUqkuN7/etlPuCUzKd8P1P7GP2WIbkb2NyqKD2AOxtJGXPP2GQGccGmAZ16RjMmM
 UqhSIDL2Y4zYiq3q1kXn0tWL/0BtPYoiVPQu2P4grNb+1xbeewsOm7gxGKmGwyKmA7zjnCO
 aWDj8UXK6NpUMI6WCKuNqDKYpsQsLAu124Bgb1oOG7numeaHSIBqxyMfH7qyFUD7VGiMsa6
 fE4KpHszLleSNgrBao8nMkyjPwwT2hNIk94YrBwutfyuaiIc6de3S5lJX7q2t3NxABPhwK6
 2Px7vvZFxrT3pTeEQq5mcc6nb7oEiS36xy0dOiqCb+T3CD+r+87fzY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

Hi Stephen,

Thank you very much for the detailed review and for taking the time to =
go through each patch carefully.
I have evaluated every comment and addressed them in v2. The points that =
are not changed in this revision are explained in the cover letter.

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, August 28, 2026 4:12 AM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang =
<zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; dev@dpdk.org
> Subject: Re: [PATCH 00/13] Wangxun fixes and new features
>=20
> On Thu, 27 Aug 2026 19:41:52 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
>=20
> > This series addresses link-related issues on Wangxun Amber-lite =
25G/40G NICs (CR/KR training, hot-plug, 10G link state), and =
additionally
> refines UDP offload handling.
>=20
>=20
> Using Claude AI review (versus the simpler CI AI review) shows several =
issues that need addressing before this can be merged.
>=20
> Here is my edit of the wordy AI feedbac.
>=20

