Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96525C0219D
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 08:56:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF56A40156;
	Tue, 11 Feb 2025 09:56:35 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 6C18340150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:56:34 +0100 (CET)
X-QQ-mid: bizesmtp85t1739264179t9uqq039
X-QQ-Originating-IP: +VaqcHnkGdp6rRA854pvi4imjdLz4sNUKJvpy0R1epI=
Received: from LAPTOP96V0OHHN ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 11 Feb 2025 16:56:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3877265363882633569
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
References: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
 <20250210110359.2b844491@hermes.local>
In-Reply-To: <20250210110359.2b844491@hermes.local>
Subject: RE: [PATCH v8 00/28] [v8]drivers/net Add Support mucse N10 Pmd Driver
Date: Tue, 11 Feb 2025 16:56:18 +0800
Message-ID: <63577437082A8172+000401db7c62$d1b99000$752cb000$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQItGVzvtb/99CFzdHQF3oghg19c4QBGCgHOspxiIPA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NDxI9psdf3YVWr/UbGqEAYlBA8NvenC/trrghdry+2V97wF/4KQKJ7Hk
 7aW16kMGYcjqZ+sYcY06FT85P25qebUR80xfxz35wQgediwIFGP//HBBzj9jNZf3Nf/Vm5U
 NUmCZ0DjhvpFI70Qq1TSA3MwO7FnCq/tama+dHpD2cg1s0J3c+eBp/yBkunTl7r2PiFhtWQ
 Ik/6HQmjmYJva3LEy6K8xZUXwIgJ2ahPtCJl+dbTZG39kMLMYlTOsYFWZGoxgPRJWdzIXBa
 MKEwbVpMkWXVnz7xGrvGic68lyv38qELEKTdtY1SHtJcL4jE8LfW0M99X3l0tYKyYhN+Kq1
 ye0jr7AcS2rBr5ayWrsoO4EHIq7jzIEgfbfHH3HsW/EMA4My0YqKEfH9pxvUPLpYIyHqeYQ
 nTzn22A05RSpWiChU71oaXocCklkdCmkg/boTO5A6KJn4Z6rktbGnIyfoMUOs5R/sXZsF8V
 xSlompDdHgHQDENQjGUfIJuQCHOYi+zyncHpawMgA1qtAGcXV+mLEyJSi3LTZ5x/VxB4u+R
 uzdoPSK0Xac4BgVWH4S0OOjB3FtLAFoRdhwuspfTlmo6kKkPK/DHDpv7u2YaUJKYu4d+XBY
 aDXEEpaRzO/sIpzBQ3l02ZjQJ+UPfprx18qH3wIKlv3OWbMCEdGioEV+aoeUTutXA9QFFEV
 zEBw1aG6WTCpmxMu7k3un9nSJPXiusdMV6rX5ghASvUY2jabL+XKq4MbnyH1vCDuKEHGa9p
 rFL2lVCBaYEMxvg7ishn4OzJJgZmxtsjDgJkKPAoqPUWyAMvl5C1dbgEI9bWJEJuU/csVNS
 wnrGj1A6aKv5WVORQ2egvU4xrUqD3TFBWsDKS+JAWJbGn7dG9em5WDw2Ab1DtDA/9/id59p
 qVAx4ncNOoycoz45nhyRbj1t6Wc08r97JSftB3SW2TxAxRNkoBZi47cuKLztfU+j
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Thanks for your guideine, I will fixed these soon.

Regards Wenbo

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=E5=B9=B42=E6=9C=8811=E6=97=A5 3:04
> To: Wenbo Cao <caowenbo@mucse.com>
> Cc: thomas@monjalon.net; dev@dpdk.org; ferruh.yigit@amd.com;
> andrew.rybchenko@oktetlabs.ru; yaojun@mucse.com
> Subject: Re: [PATCH v8 00/28] [v8]drivers/net Add Support mucse N10 =
Pmd
> Driver
>=20
> Driver review checklist for mucse PMD
>=20
> Mark items with:
>     =E2=9C=94 passed
>     =E2=9C=98 Failed
>=20
> Basic hygiene
>     =E2=9C=98 Look at CI results in patchwork; notify submitter if any =
failures
>     =E2=9C=94 Merge cleanly with git am; look for missing newline at =
EOF etc
>     =E2=9C=98 Run checkpatches; warnings are ok, but look more =
carefully.
>     =E2=9C=98 Run check-git-log; often get some minor warnings that =
are ok
>     =E2=9C=94 Run check-symbol-maps.sh
>     =E2=9C=94 Run check-doc-vs-code
>     =E2=9C=94 Run check-spdk-tag
>=20
> Builds
>     =E2=9C=98 Normal Gcc build; make sure driver is built!
>     =E2=9C=98 Use latest experimental Gcc 15 to catch new warnings
>     =E2=9C=98 Clang build using current version (clang-19)
>     =E2=9C=98 Doc build
>=20
> Rest of checklist skipped, not worth running with these kind of =
failures


