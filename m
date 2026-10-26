Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CA606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:29:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46ACD40658;
	Mon, 26 Oct 2026 13:27:39 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTPS id 0C66140A8A
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:27:36 +0100 (CET)
X-QQ-mid: tivesync4t1793017652tb22959b5
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.227.112.25])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 14846046250546651095
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>	<3C29C180B4E33816+20261023110728.3975-1-zaiyuwang@trustnetic.com>
 <20261023090117.34672036@phoenix.local>
In-Reply-To: <20261023090117.34672036@phoenix.local>
Subject: RE: [PATCH v10 00/17] Wangxun fixes and new features
Date: Mon, 26 Oct 2026 20:27:30 +0800
Message-ID: <00b001dd6545$5ef75840$1ce608c0$@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ8QNehdnXO5ExpIOsSsHb9Qgxp5wHIlCMqAgOLsn61s6R7YA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MmzhuZHLEAbbY25Z2xWmGok9nNJF9m7Am6ElzBvnK2pP3zsYI61J2WqY
 tgo6zbcmyCrb7NVmZ0zrDrQgNNI4/PvTHlM4rzeBpcqX1df9s88fvgmUJqkbAQzpm+srvkp
 KTB/qzDVPSX83aM3th6eJzNWPEkwujw0rsooBF+Jiiv+WHlzXNqT7PUUKTbKJZNhLy1O5kb
 To+/5JtD3lx0cOhh428vUMAb8ScgqjT3Eb7M1p+zn+LKRGm+AZBByxY9UBLlUcDzQtuifg5
 p2rr8//v9Y8twv0m7YHjKhAn/HEwmz1FLpVq8LLdF885+zLOyM68FUyF5FjOkz3CMoRLOU5
 x6OfEPajroae0zUysHokW9GMHuMfpZ7rshAI26hwbtBIus/oS3YxgrIgQVm3yqPb52TFFm3
 gemMWvanF5+Nh2JcUGP1Xus6VlJFAtsfhFdudh6OmvsqX3nEZ5KmF+cP4y9rL1dKtfl7RO9
 lJahyEWzseZVWpGXi52wMmfhyCyir+n9qlJ/HmuB0udIfitaN7rHikvdQ1BMrA5R5ewZldF
 x9V1u9j6xo9OzJDkVqghyNg4OFP2EWiGjotOY9fLewNhdedFg/+ZvYiqFlEAInfijXSJZ+5
 SH/xn2eL1nteG1w/6NaOpLCmaplo5jGAA5f2eangaUGwYN9Zh/8Iamm0/y3kjyzAmMehi0R
 394y3YxwFq7eugAvZ0sQUEoTj77mfukYvIasvaR9GA81aE+X/4AxpvJvi+5PKCki1qSzlKt
 LfJY3xREJBRsOBkbezk0JMUBQT7Y/cDP4HMkTCoRI8RuwUQezLdI4BFdOyVcovbFM5043G9
 bHOrioyWfBAw3+6fs3WBori7xy26PMXK+cmDbFadLitYXoCpaKTZtAIKr3LpRByjfWjw+ks
 Z4yGivYY6CKMCjOAOO0XISaRq/WHQMGM/3QQq2qNdzIR/JeXs6INqW36V2WBo96MImPLw/h
 LYzI2VI65gZZL8HBCzM6RyKwt7eNmSfOgVgH9NFoYfz6LLiMc2AHtVVXl1n78hmLUZZOmMj
 5aQul/SJNJuEOeNERD2oM21wl1po0F97qVTVjgQtahWLh7SgxEMvMzYry0nU0NPGX1Wyr3U
 P8jvYq3ZaqxBHYWqS5/onQGlLJ60cEcm1GOrAmj+BTy5ffIbQ4aMXKnkvFdAh4Jm73CZkuz
 zk/W
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Most of it is fine, but you still are keeping a driver specific behavior around PHY control which was identified as not acceptable
in an earlier review.
> 
> I object to cases where driver writers treat their PMD as a unique and special case because that would end up tying the user
application to a
> specific PMD and it makes it harder for users to manage and write code.
> 
> If there is a missing feature in the ethdev management layer, then control operations and offloads should be added there and
drivers should all
> work against that.
> 
> The current AI review reflects that.
> 
Hi Stephen,

Thanks for your review. I accept both points, and v11 has been posted with
the corresponding fixes.

Now the laser_off devarg is gone, along with its documentation and release
note entry. Tx is now disabled unconditionally when an AML40 port goes
down, and link setup runs again on link-up to restore what link-down disabled. 

You are right that set_link_up() is a control operation and the application asked
for the link to come back up so renegotiation is the cost of that. There is nothing
missing in ethdev here either. set_link_down() already defines what should
happen; the driver simply was not doing it. 

Thanks again for the review.
Zaiyu Wang


