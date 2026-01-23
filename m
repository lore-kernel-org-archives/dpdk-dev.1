Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656F5D2F02C
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 14:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32C8240E0C;
	Tue, 27 Jan 2026 15:24:09 +0100 (CET)
Received: from rn-mx02.apple.com (rn-mx02.apple.com [17.132.108.1])
 by mails.dpdk.org (Postfix) with ESMTP id DAEC64021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 19:35:50 +0100 (CET)
Received: from mr55p01nt-mtap01.apple.com
 (mr55p01nt-mtap01.ise.apple.com [10.170.185.217]) by mr55p01nt-mxp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.28.20250821 64bit (built Aug 21
 2025)) with ESMTPS id <0T9B1M34PYBQ5W30@mr55p01nt-mxp02.apple.com> for
 dev@dpdk.org; Fri, 23 Jan 2026 18:35:50 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=aVCU/FXijPJsOcNMSfnVHAgCPio/6lfKnpZyFUuvBZE=;
 b=YDnxcMgHYL+NQBVhBWgoGyIpq4eZDPDA9u2v52IDehEJmkXZDEfXV9Ohtuoyc4qOs+31
 D32C3dgdVgqDE9Y2MxFp9e9hn4FHeRPrQLnm/EZsOx9KQogqzzGihsIVZamIv8vUu4s2
 666iWBizMdlQ54BR0vcWtQKr/tKJErEWt5ru1F9HxOW811rcIWVk8bzUoDRyrRdRr0ZS
 C9nF9wY1hPUUhFk0oj0WgJ1jA1a4KS29dpnNULSiwHLk5o07NnqmP8JlINKeQYWk+MsO
 teCNFIIO+PjhOOspX6CCqOfBsYq+kOU89J3JWr5SGGTqQG6vvK1LOGGu0l7dTSdozYqR pw==
Received: from mr55p01nt-mmpp05.apple.com
 (mr55p01nt-mmpp05.ise.apple.com [10.170.185.201])
 by mr55p01nt-mtap01.apple.com
 (Oracle Communications Messaging Server 8.1.0.28.20250821 64bit (built Aug 21
 2025)) with ESMTPS id <0T9B2DTB9YBNAIY0@mr55p01nt-mtap01.apple.com>; Fri,
 23 Jan 2026 18:35:47 +0000 (GMT)
Received: from process_milters-daemon.mr55p01nt-mmpp05.apple.com by
 mr55p01nt-mmpp05.apple.com
 (Oracle Communications Messaging Server 8.1.0.28.20250821 64bit (built Aug 21
 2025)) id <0T9B07X00Y6KEJ00@mr55p01nt-mmpp05.apple.com>; Fri,
 23 Jan 2026 18:35:47 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 5a2a44f13f28f5879804f360a3795a01
X-Va-E-CD: f40acba1b1377b2ca109670d1f0feaf5
X-Va-R-CD: 89f4ffde9da73bb2a30c3df471ee8654
X-Va-ID: b99086a4-ed6e-492a-823e-9aceb9930032
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 5a2a44f13f28f5879804f360a3795a01
X-V-E-CD: f40acba1b1377b2ca109670d1f0feaf5
X-V-R-CD: 89f4ffde9da73bb2a30c3df471ee8654
X-V-ID: 54e36034-1b4c-42df-8314-abd4fa42dbed
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
Received: from smtpclient.apple ([17.234.19.51]) by mr55p01nt-mmpp05.apple.com
 (Oracle Communications Messaging Server 8.1.0.28.20250821 64bit
 (built Aug 21
 2025)) with ESMTPSA id <0T9B07E6XYBM4300@mr55p01nt-mmpp05.apple.com>; Fri,
 23 Jan 2026 18:35:47 +0000 (GMT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 v3 2/2] mailmap: add Scott Mitchell
From: Scott Mitchell <scott_mitchell@apple.com>
In-reply-to: <98CBD80474FA8B44BF855DF32C47DC35F6568A@smartserver.smartshare.dk>
Date: Fri, 23 Jan 2026 10:35:36 -0800
Cc: dev@dpdk.org, scott.k.mitch1@gmail.com
Content-transfer-encoding: quoted-printable
Message-id: <0524677A-D643-491D-8E9C-A062AF1DB7DA@apple.com>
References: <20260111160059.293-1-scott.k.mitch1@gmail.com>
 <20260111160059.293-3-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6568A@smartserver.smartshare.dk>
To: =?utf-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Mailman-Approved-At: Tue, 27 Jan 2026 15:24:07 +0100
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

Thanks Morten!

> On Jan 21, 2026, at 10:27=E2=80=AFPM, Morten Br=C3=B8rup =
<mb@smartsharesystems.com> wrote:
>=20
> I have verified that Scott replies to the Apple email address.
>=20
> Tested-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Reviewed-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>=20
>=20
> Venlig hilsen / Kind regards,
> -Morten Br=C3=B8rup
>=20
>> -----Original Message-----
>> From: scott.k.mitch1@gmail.com [mailto:scott.k.mitch1@gmail.com]
>> Sent: Sunday, 11 January 2026 17.01
>> To: dev@dpdk.org
>> Cc: Morten Br=C3=B8rup; stephen@networkplumber.org; Scott Mitchell
>> Subject: [PATCH v3 v3 2/2] mailmap: add Scott Mitchell
>>=20
>> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>>=20
>> Add email mapping for consistent git attribution.
>>=20
>> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
>> ---
>> .mailmap | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/.mailmap b/.mailmap
>> index 2f089326ff..a0987fc3c7 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -1437,6 +1437,7 @@ Saurabh Singhal <saurabhs@arista.com>
>> Savinay Dharmappa <savinay.dharmappa@intel.com>
>> Scott Branden <scott.branden@broadcom.com>
>> Scott Daniels <daniels@research.att.com>
>> +Scott Mitchell <scott.k.mitch1@gmail.com> <scott_mitchell@apple.com>
>> Scott W Taylor <scott.w.taylor@intel.com>
>> Scott Wasson <scott_wasson@affirmednetworks.com>
>> Se=C3=A1n Harte <seanbh@gmail.com>
>> --
>> 2.39.5 (Apple Git-154)
>=20

