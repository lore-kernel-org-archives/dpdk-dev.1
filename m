Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B78AC36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 07:35:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F61540268;
	Mon, 24 Mar 2025 08:35:01 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by mails.dpdk.org (Postfix) with ESMTP id A048840151
 for <dev@dpdk.org>; Mon, 24 Mar 2025 08:34:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcUkRqJ63se8i5Le/dVeBJA9qS6xXzcvFZLSmECDAZ9GbDayz9Nb4BGGeRX+Ss+REbYwIqGZosw9lSnaLMO++ebOvQiIXKTG+J1cP/7/u+DlodhJ8Kx9JRA+q5WOkab46Uc+x62COa9oC8KCS/9Batq5NclFcJBXb4DgNbrIerbWQ98uLKv1kqUcTpFxut6bsu9pffTXekEXM3CUiqAy8sSdfKuSXGBQe9DV6w71/zVF1zpSmLa8HMl+RtUnFlPf2XPVt2NCak+0+sY53OBZ+n3sU1wPacGXE6v/2/7GZ2mWMWp6eiYtYESi45gUhbBTA0sb6Dt0uhKRF3FIdaTy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQFmPH49wlLU5b4QQQBfS3tOQxYhEhBsjrYISSJv2b4=;
 b=HM1fWU2HdwX9QThBfQSybwoAenOmiUgfDJ+HaZktQbB4xaGQMWKjVlcsL2f068vzSK1FUbOxT7KRnhjeU9mk00PtH8FsC2mncoNH7kTUozmKCu/55At0ccC9cR+ZBqfHqJJgT2lrNFaquiCMAzharG9EUx/KFdfgv5Dq4bYYRSpmi8JIBguuE7VjSmsFB2zIbayzg6SYFzSxQqwANqira107MjENnmNx12saOs6xK3LBjYd7P266I2XBzCKr1+HKKf0EFJqSjYr7KGrak27yr/yjs0uUf5/2bhCqtoOfQrK1xRfn1YKf2JSkwrwyGD/q80KY+7jerdgnKOCNovfw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQFmPH49wlLU5b4QQQBfS3tOQxYhEhBsjrYISSJv2b4=;
 b=VyKnvJgLvj0LpZjFsEF4yiQoo8XGxzVQZ6ol8TvxAhTfK8YaR6gLyVDZyEvyOlfrAmbAqyWmsAH/uEOLvrO7k/TF7xThWa7rnkz8s666/rL/t7u/CUTtWh/BOGEw60bmnNbIhVl5IEtwzy90oUTVej1xHqCYeN/35cBYqjGQrC8nxRvJrMHBFPbPXhj5sa4VxAHh5hQZKKPMJHkLBcktQHffSpxnVYGgKiFRS6a9YfIzpjwssVH/h/S3ZGPgOOZUXymm4iUgDcfsQRUB4Qfc8tSwYswFzMFtxVmp7AnHOVjQuX6qew2BBkHbd6Yc8Ll8TjX0LXMuzFthUUFxO8lEGA==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:34:57 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:34:56 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "haijie1@huawei.com" <haijie1@huawei.com>
Subject: Re: [PATCH] app/testpmd: fix VLAN header parsing
Thread-Topic: [PATCH] app/testpmd: fix VLAN header parsing
Thread-Index: AQHbm+8qBy++gaakq0m8DcV6iO248LOAszuAgAEyu+o=
Date: Mon, 24 Mar 2025 07:34:56 +0000
Message-ID: <CH3PR12MB8460B2A2A61615F589182A32CFA42@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250323122822.90407-1-rasland@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB3D@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB3D@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|SJ2PR12MB7799:EE_
x-ms-office365-filtering-correlation-id: 1964d9bd-f0b7-400c-ee45-08dd6aa6602b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uWjLIt3bbIPHpWjSEh9Jst/zQE1u6S3dtUm9zCGLf3hIcVOiCezXJwG7rL?=
 =?iso-8859-1?Q?x6TsaFLbR+2NrhPTYwMrFXuykwUJb2Vlq9U74yyf4cnTW7sIRdCBWY4u4c?=
 =?iso-8859-1?Q?i1hdqNDbb9Hw+4+6ijRUZxlUEiw4xsTmyk09/b7NOS1F4zA3e5wcA+0Ag2?=
 =?iso-8859-1?Q?teMWbKKt5RYFds4yt7ZWbELsqWnS5EV1p4y6h8iLIWuWSh02RwnEaXWT5P?=
 =?iso-8859-1?Q?lKLmbLG4qdVDmqzwZRs8WiRTjIbA09W6JYRQ+x47FhVCI917k1k+RqsrrW?=
 =?iso-8859-1?Q?cmlHrr75YTR9qKi2Tj8us/NPfU6yNix7xqfEdtdKEP7ZDAlF907+Ixvt6Z?=
 =?iso-8859-1?Q?48nnzc+Fzcs8t2hhK4jpoyaxmwhbBFcAFKvzV6CWvetnZ3FvybeAXLDOwX?=
 =?iso-8859-1?Q?DJ3uGkl+s2Me+HMPWCW2kwsoIgJuTOhfCWGsGMjgggKUFXptWOe9d76q3y?=
 =?iso-8859-1?Q?5LX4eiXdjhJve50DLp83XWHFxr9T8HObO6RfICvZT249A6crbG9yRdVPoZ?=
 =?iso-8859-1?Q?oINZFTmoiORGU4LmtKJeoMqvhYRaPOKqgaIYvQp0KovEvTrJXZxlch3ksc?=
 =?iso-8859-1?Q?u3be3YyqptZdAvX3eNuZIlRBY0PH2hdVWXyvnYiKgVRK7ZOWW2h2DDbB73?=
 =?iso-8859-1?Q?BKShEcZA0r8wTYXMhtrHA6xJUb7+SXnHFPKDGIKfPRctpzIJih6VK3OyK7?=
 =?iso-8859-1?Q?ufg97bWrWx/T7hfsZVkCQN4NSBQBdsoB8QSwpyGIO1AMOP6NYySx+U3rmq?=
 =?iso-8859-1?Q?TWithmxJp4WS26DYgXGGE+tOCZAciUG5/nhzZJ9DaPjJG35Zuh/RgHTbYI?=
 =?iso-8859-1?Q?/V14hH7wkcrSh8Ucl3zccmem9kUuSZlAsLUNrOGyOuKypNNMw3F5/n8taz?=
 =?iso-8859-1?Q?4VLpTtE7ZXjHJb2EVgQvjHOljM6Xyx7FdRzCXu5KNAldJrvmh+7Tem9Lbv?=
 =?iso-8859-1?Q?doFwhR8fxNdkvdhT6+G8xhRhkY8eiQIKTqH/+0UoIdY8WIZxT12r618NER?=
 =?iso-8859-1?Q?UTP3OdI48uMyQlfpyc0hXgI9FgnS2qBtx6xZ1S0sjBJHfE4YOl0L+5DPuI?=
 =?iso-8859-1?Q?3qldTb6NZ3H/+WnMDMPDLGproQw/2LIvknufDPXZU7uIUyQlQSEU4d3zpT?=
 =?iso-8859-1?Q?m1p/OFvs2nRgn4IXHxLNJm5J57oeYdV8b26MbLk3F9K36LiXvcOY0nUyvk?=
 =?iso-8859-1?Q?XJzUi08KqNWo3YqOk1aldzpb7umfrGo7L8uUv3t9X2RZ60EftyYMJMuUxJ?=
 =?iso-8859-1?Q?wnI5qOs8vnOlgOA+ZomJ0Tv22pQuQMvo/ugU2HuyJtWHFy5qD/KrAN8/cL?=
 =?iso-8859-1?Q?Ww0wmMFkO6FH6C73RE3BYYQLf6l1FiCu+4Qf6u3RrPbkbSzfQMVMGlzE6h?=
 =?iso-8859-1?Q?G/uZ7ygjnYX1XjAEzXe2yfzSazaupPVUlnkrh0XQBolicvB+MfZKnPtkGR?=
 =?iso-8859-1?Q?muuQZBq64ojwaM0kkiXaPeZ4yieJJnxzcGa1xaXfAmfuqoEJnpOqnS1em2?=
 =?iso-8859-1?Q?ZGI5+DRuMO2f4zz2RY2pRi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JDBHw6aV9bhuCe+uxNkCOyJZtCDVO4Ev2saXZsawqUhtgCGPvYRBbLRwi3?=
 =?iso-8859-1?Q?LltIAMoeeIykn8d3Tz5Uy0b6MoR9KuHZpo9BiE7iPS9ukWoPx4y9n4tc6w?=
 =?iso-8859-1?Q?dTWs90bK/T+oJrUuMO72YCwrIMo8jqo2zw3vGk8+zYv//yMMUhaczItfJq?=
 =?iso-8859-1?Q?lHro2KnlfcsPmUPoR+ETTiMW07YTzBQrd0juKHg2o9V2uJpIb9yT4i+zXk?=
 =?iso-8859-1?Q?HJtOCBAx3Qx/Uwb6XHB7TH3LgWo+z4zlbbPkdIAxXX1eNVh+NEkeg+mbJH?=
 =?iso-8859-1?Q?l8Y5k9FEwlvVyqWLiRCBAz7jgPqSM2/mKjZYl24D71JLxl8P424pMUkICN?=
 =?iso-8859-1?Q?4XnZy1hJAiapC3BRvwpzGV1+IGkKJtSwvGIO+E1g5sF8IxGO4eFEMobaRi?=
 =?iso-8859-1?Q?CnP80/BoMfajPB5Q1nEfRxW3gxmdawukPtHPa2+jNAxGdhU2A7BYHumqaI?=
 =?iso-8859-1?Q?rJYxh0Kmq80oU5udOCMKFRyhGZyEVPX4jDt0hJUppe8slVsR+DT8pdDGDA?=
 =?iso-8859-1?Q?RUnJjokpcKxxBgOdUv+9wnD46ojicQnViUt5B/TjzjKCWil2tGBX7agtYm?=
 =?iso-8859-1?Q?d6/7Lk03w4lAb7e2rnwUCuQgfXeFnRHznpX/7eV3DUv+2BZRfWm9LrrjrL?=
 =?iso-8859-1?Q?Iotg5kj5z4/xyPhg1ot4onPBbJ5nAr3D8454CvF2FgZu1h2Tl0i4+MpJ9a?=
 =?iso-8859-1?Q?i/BYLUkxn8T3M//Y3U7fPmNjS4LXdLCbVIjDlBsRkNYZOsorgmyK262nif?=
 =?iso-8859-1?Q?migiBB/tHVpeutz1NblI6F6rfv24AXZtU65GRaIDwgJjTXqTGhIfzjFvew?=
 =?iso-8859-1?Q?/BQlrfRqaFiFY9Ss9CIQGEX9UPvykOJBIhOVmWJ3pnLdSpeNxePR+Vhzp3?=
 =?iso-8859-1?Q?PwWg34fH03mj43fusgiroOlyu19N3HxRy+bltPyAMAuyXMNPOLUo2LAChm?=
 =?iso-8859-1?Q?hcaTjrv/ce5a7sLo/pc3xm99JdebUk7GUnkZGK2jVfDTIqU6tdhVsPWfoU?=
 =?iso-8859-1?Q?W+nowqj+MmI6qZXDrf3h9aqOF+8xEDIVRx+a3Z7mEf6b50iX4FYPDIIbID?=
 =?iso-8859-1?Q?ViHGtFGo0TAE7l65qp25xkf2LfKXIK7q9bE/N30nB6DjelSHS7wl5lJUkp?=
 =?iso-8859-1?Q?K6JUwdlNHQqJ6KXerT96zH0Qtpgw8Sr454DB36jOPwSAF84ZY0CCi2LAwv?=
 =?iso-8859-1?Q?XNuTGpKAn5+GRZXhrHX2FoO9s8B99arl6+to4Yx7WTEeKVvxvXsytglLPY?=
 =?iso-8859-1?Q?k86kHqSXJGeU/F9LHceQIBegN/z57VvlbcipqyX5ZLopCqrRp1fpEX6w0t?=
 =?iso-8859-1?Q?ine9IWjJ/ij2uJOC5rq7ULjZceTlCEk+EHB4vqO2BVj3LYnUjwVM/fySsU?=
 =?iso-8859-1?Q?RNjvfR51N5K0rMxEIgudmYweF96djxZJq3CMRs+jBviiDTySB3D2+yhlco?=
 =?iso-8859-1?Q?hRtIotiLHlC1jF/I4uvw/3ECwFfkAEcgOPeVln0rnv2xPT509/HUGaQ7Ue?=
 =?iso-8859-1?Q?Pn5nfDsGiz18k82XMjsZkyU3Zf2mWsGkME/VQaX1S0050m3N2VSv6OMfyQ?=
 =?iso-8859-1?Q?0LBOeF+1kRb6WDMiLI+MObQvBcfDORn0Iolhnv3zLdQ3RiMV4oJR1pYHiu?=
 =?iso-8859-1?Q?zcMHDy/BSo/VgZ3smXnWIQowV2h1yEPTygiU5hVAOG7r8eVY3r//JnWQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8460B2A2A61615F589182A32CFA42CH3PR12MB8460namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1964d9bd-f0b7-400c-ee45-08dd6aa6602b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 07:34:56.6573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDDj8LKJjBUc8rZCle3SWsNzp5M650jjEnPb+aQYp1fnWSWMUK5l4vHbw8YASkybMwq/O4E/TNEnZUgrt/B/Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
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

--_000_CH3PR12MB8460B2A2A61615F589182A32CFA42CH3PR12MB8460namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>> From: Raslan Darawsheh [mailto:rasland@nvidia.com]
>> Sent: Sunday, 23 March 2025 13.28
>>
>> Updated the `get_ethertype_by_ptype` function to correctly parse VLAN
>> headers.
>>
>> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
>> Cc: haijie1@huawei.com
>>
>>> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
>> ---
>>  app/test-pmd/csumonly.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
>> index 5b906eaa53..302cc4cc66 100644
>> --- a/app/test-pmd/csumonly.c
>> +++ b/app/test-pmd/csumonly.c
>> @@ -468,6 +468,7 @@ get_ethertype_by_ptype(struct rte_ether_hdr
>> *eth_hdr, uint32_t ptype)
>>  {
>>        struct rte_vlan_hdr *vlan_hdr;
>>        uint16_t ethertype;
>> +     uint32_t i =3D 0;
>>
>>        switch (ptype) {
>>        case RTE_PTYPE_L3_IPV4:
>> @@ -486,10 +487,11 @@ get_ethertype_by_ptype(struct rte_ether_hdr
>> *eth_hdr, uint32_t ptype)
>>                return _htons(RTE_ETHER_TYPE_IPV6);
>>        default:
>>                ethertype =3D eth_hdr->ether_type;
>> -             while (eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_VL=
AN)
>> ||
>> -                     eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_Q=
INQ)) {
>> +             while (ethertype =3D=3D _htons(RTE_ETHER_TYPE_VLAN) ||
>> +                     ethertype =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {
>>                        vlan_hdr =3D (struct rte_vlan_hdr *)
>> -                             ((char *)eth_hdr + sizeof(*eth_hdr));
>> +                             ((char *)eth_hdr + sizeof(*eth_hdr) +
>> +                             (i * sizeof(struct rte_vlan_hdr)));

>Doesn't work; "i" is not incremented, and remains 0.
>Instead do this: Initialize (struct rte_vlan_hdr *)vlan_hdr=3DRTE_PTR_ADD(=
eth_hdr, offsetof(rte_ether_hdr, ether_type)) before the loop, and move vla=
n_hdr+=3DRTE_VLAN_HLEN inside the loop.
Yes you are correct I had a (i++ *) but must have slipped while rebasing wi=
ll handle your way in v2
>>                        ethertype =3D vlan_hdr->eth_proto;
>>                }
>>                return ethertype;
>> --
>> 2.39.5 (Apple Git-154)

Kindest regards
Raslan Darawsheh

--_000_CH3PR12MB8460B2A2A61615F589182A32CFA42CH3PR12MB8460namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-PS" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:36.0pt">
<span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span style=3D"f=
ont-size:11.0pt">&gt; From: Raslan Darawsheh [<a href=3D"mailto:rasland@nvi=
dia.com">mailto:rasland@nvidia.com</a>]<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; Sent: Sunday, 23 March 2025 13.28<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; Updated the `get_ethertype_by_ptype` function =
to correctly parse VLAN<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; headers.<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; Fixes: 76730c7b9b5a (&quot;app/testpmd: use pa=
cket type parsing API&quot;)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; Cc: haijie1@huawei.com<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;&gt;</span><span=
 style=3D"font-size:11.0pt">&gt; Signed-off-by: Raslan Darawsheh &lt;raslan=
d@nvidia.com&gt;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; ---<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp; app/test-pmd/csumonly.c | 8 +++++---<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp; 1 file changed, 5 insertions(+), 3 delet=
ions(-)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; diff --git a/app/test-pmd/csumonly.c b/app/tes=
t-pmd/csumonly.c<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; index 5b906eaa53..302cc4cc66 100644<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; --- a/app/test-pmd/csumonly.c<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +++ b/app/test-pmd/csumonly.c<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; @@ -468,6 +468,7 @@ get_ethertype_by_ptype(str=
uct rte_ether_hdr<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; *eth_hdr, uint32_t ptype)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp; {<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct rte_vlan_hdr *vlan_hdr;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
16_t ethertype;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br=
>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swit=
ch (ptype) {<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 RTE_PTYPE_L3_IPV4:<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; @@ -486,10 +487,11 @@ get_ethertype_by_ptype(s=
truct rte_ether_hdr<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; *eth_hdr, uint32_t ptype)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return _htons(RTE_ETHER_TYPE_IP=
V6);<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; defa=
ult:<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethertype =3D eth_hdr-&gt;ether=
_type;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; while (eth_hdr-&gt;ether_type =3D=3D _htons(RTE=
_ETHER_TYPE_VLAN)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; ||<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 eth_hdr-&gt;ether_type =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; while (ethertype =3D=3D _htons(RTE_ETHER_TYPE_V=
LAN) ||<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ethertype =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vlan_hdr =3D (struct rte_vlan_hdr *)<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((char *)eth_hdr + sizeof(=
*eth_hdr));<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((char *)eth_hdr + sizeof(=
*eth_hdr) +<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i * sizeof(struct rte_vla=
n_hdr)));<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">Doesn't work; &quot;i&quot; is not incremented, and=
 remains 0.<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">Instead do this: Initialize (struct rte_vlan_hdr *)=
vlan_hdr=3DRTE_PTR_ADD(eth_hdr, offsetof(rte_ether_hdr, ether_type)) before=
 the loop, and move vlan_hdr+=3DRTE_VLAN_HLEN
 inside the loop.<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">Yes you are correct =
I had a (i++ *) but must have slipped while rebasing will handle your way i=
n v2
</span><span style=3D"font-size:11.0pt"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ethertype =3D vlan_hdr-&gt;eth_proto;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ethertype;<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; --<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;</span><span sty=
le=3D"font-size:11.0pt">&gt; 2.39.5 (Apple Git-154)</span><span lang=3D"EN-=
US" style=3D"font-size:11.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">Kindest regards<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">Raslan Darawsheh<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH3PR12MB8460B2A2A61615F589182A32CFA42CH3PR12MB8460namp_--
