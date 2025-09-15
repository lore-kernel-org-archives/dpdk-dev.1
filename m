Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C28CAC598
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 10:10:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EA1140611;
	Mon, 15 Sep 2025 12:10:48 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id ABA8840262
 for <dev@dpdk.org>; Mon, 15 Sep 2025 12:10:45 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023133.outbound.protection.outlook.com
 [40.107.159.133]) by mx-outbound14-229.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Sep 2025 10:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0riz0wIjHVU5DKlPL0QqPuhN6LpXQ08lgnhDncSuihLk+hrdWG2TMiwimzaH5vMuDOyW+IT3Oi6gmfAG5xDVzxYNGSnf/+imw/L9Cph36RMS7zCIYhn94shmIqe9r1hHy0Gf5466YRcMDI/tRE2Twrm5GvS47s+vrMubxlLzCeylCjA807MSYtpWoKzFIyBCLIaaJU02cHYGQNBkxNkaDBxHO74XnFubsJeitzr5Fw/DLx281d3uhQ5yCTwzSOKjaoyFTPns6OCbTTeQ3/4mvLL7LXSMsXlK5vuyNgN9GBo2hAPM2/1IjUOjMvgZJFgEtb8gOEdTx9PKT8RSDnGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YZoIYCmjZSh2TYCtn1nbzlZOYddcl4dYRK0YxoPIsc=;
 b=rM1Mv7G/UWAZtzWM4MM2pi92AS/0QLEtW63x2BivvH6zTOdJ9wiFD0Atvs8cwLRiJdsfe9Pa3BSrw63gUIh7dTjWfaP7gIuQ+mll/1S55O4K0xWUy4fr1wfc/OxnnhhzbXKlfhxLRNYXpkkd+p8sEV4WKDXod194nG5Puhm2xSaeMNc+gJ6sGy1X05Km0ReeITA1XLzKOs55sXy3zJnWPV4Je5JxNAV2gigKK1tjDH0aybSh9i10MOCCe42Li/U1PkpGLolRto3bmZBm62aWGtCNwkKudEw3luRXH02arOqYUkDEUKAYRPRRnuOWFfTQL85ef54voNGNJcG8q07VsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=napatech.com; dmarc=pass action=none header.from=napatech.com;
 dkim=pass header.d=napatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YZoIYCmjZSh2TYCtn1nbzlZOYddcl4dYRK0YxoPIsc=;
 b=dAD+nMT+9M4ryX1TCakcEfwKXw2ZVUFzBhS0mBoiKysgHkNjL9MLgPpkem4pygJgw7Yt4PbOWRnVhdI27jXAG+ni6vHTG4f7vPmaNnef1u8PQjWU48OFIVZ49glKMep663uzJ40RraAWOC5DfqjxnJGLgNdvKHpyud3684GUDH0=
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a9::5)
 by DB9P190MB1195.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:221::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 10:10:39 +0000
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3]) by VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 10:10:39 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Mykola Kostenok <mko-plv@napatech.com>,
 Christian Koue Muf <ckm@napatech.com>
Subject: Re: [PATCH v2 1/7] net/ntnic: introduce service API for NTNIC PMD
Thread-Topic: [PATCH v2 1/7] net/ntnic: introduce service API for NTNIC PMD
Thread-Index: AQHcIMtbs8wf0vEVgkCtO5K3aRZYrbSRU8UAgAKReOw=
Date: Mon, 15 Sep 2025 10:10:39 +0000
Message-ID: <VE1P190MB08305B788F9E11C757A19CFB8015A@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
References: <20250908110446.1071964-8-sil-plv@napatech.com>
 <20250908141740.1312268-1-sil-plv@napatech.com>
 <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250913092304.1ca77333@hermes.local>
In-Reply-To: <20250913092304.1ca77333@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=napatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1P190MB0830:EE_|DB9P190MB1195:EE_
x-ms-office365-filtering-correlation-id: e573d450-c7ef-4e7c-9e97-08ddf4401f16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021|8096899003|13003099007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?w+Wmx4/UCJb0xLtVxRlBtUrsWmcWQ37Waa9fzyEwgIViDQ687fKGI/I2dw?=
 =?iso-8859-1?Q?NqGqt2+VfcT1JWgqleeudXhjYdMZhdNKReNKrHZSwiFy82I7eOsdv6yngn?=
 =?iso-8859-1?Q?r1cj5LeRhmtpEyG9LXtJ8yNJEfOpVDBs89Uc2/Hj5C1smVnQh1/sJEqr22?=
 =?iso-8859-1?Q?FIZ6tfHD7UYzyMiWjUfIrsorSk84hd8D2A7XllkYIUpO74aFm2fLVB/aXr?=
 =?iso-8859-1?Q?KU3KUTn7sGsCuFrfKy2pfGVvyzJKRTq9g9UUrkVtDIf+g88xY/T1RB1JRs?=
 =?iso-8859-1?Q?lRwx0byz7cZMGwsQMAd2FmC4WGQufLdr4Ws4THij8dnGhYfxCQjOQ/B4yM?=
 =?iso-8859-1?Q?limCWzF9xTYW6N7tK0vmAUGLjoOpBLA75eK74pAHoq60ioYVZi8D04yiEO?=
 =?iso-8859-1?Q?SvFQT+9l/w+qW3FujMoIuJARF/78H91qQE21j9YxW8F5x+NaDgyWMaKalP?=
 =?iso-8859-1?Q?NCJ88W6bIADwa/iFenntlewjpaurDj6c85chR5yDQNW/K3sXA1cqUjn0ld?=
 =?iso-8859-1?Q?Bj+Or6WWFmbErq6APJ6+DxJjSN1uwO/e6fRlR34SVi/G0DcR4PNBYdALSB?=
 =?iso-8859-1?Q?vewawKyKubgLhYjNYeQMSiaa9A3XdFua7HqwfBJCiiANVB2ObIjwZJLsGq?=
 =?iso-8859-1?Q?HXXPn04b/hlmFcuwh0Fk8meOnzR6hU/fmVCmEo6sQGwb0NXiP62bq2JFmD?=
 =?iso-8859-1?Q?8ES3Fl8S9w3vwLOpjZHH6WR1PdUCMKFijg2jyrcVA2nj7nxygqPK2nFSvU?=
 =?iso-8859-1?Q?QZzx0efT1+QLEk6r2A4784WJGGTva+ngBjJPE3zofB+kMf2y/DcI3dM4dg?=
 =?iso-8859-1?Q?gMvv0u6pnIisBB+hQJR6gC1XkPhF3GWBL5kjMKsfnKwNjapUo9bXUfEwRK?=
 =?iso-8859-1?Q?2UeMjX04UE6kZ7jP5S/DcK0KXr6eI5xXempYPeJkxoTDTsLM6g/4A9+mMd?=
 =?iso-8859-1?Q?JfgxvSZKZZMnp1hkKfFRRCMogDkyPeiJsF1ZQ8+U4dzxCfJl5Rp4ahCKsP?=
 =?iso-8859-1?Q?S/i3+JwtiN3YfElT7ox8SDw1bduUtxG3VveXvXt40BdcvO98Z3wf5/w2gY?=
 =?iso-8859-1?Q?Ri/kJvTzaKi702HnU8xFEUmFWFRHcYlKhB2eKEQs430Vv4tvY/BDRzwCj0?=
 =?iso-8859-1?Q?3vjXowN0IZj+bYPRHDa4TvZLbxFg+u8E8ePiQu/MMYZAEUZMGtT7sI0ur2?=
 =?iso-8859-1?Q?vOO8Jsn/apPFvEiBmT0Uwn4x2OsMMlpT5Y7JLMGuOwfxxk94zv1D3Gi7TG?=
 =?iso-8859-1?Q?aNRx1OdDi9Xu/n3BCICeybYKr64MTaVrp5HqDh++vnFmMkKBbbOt0RZy7d?=
 =?iso-8859-1?Q?px1WQ9r+UPvwIE1OrbA0SNJdgisO4nVwXx5R3xkba1PmvEJjdiITaj5S3t?=
 =?iso-8859-1?Q?2TkV2kZysJSWXoVZS4T0ckzxQUcNJPlQ0uVeebHwB9x+f/bJgjQKqud57p?=
 =?iso-8859-1?Q?3e6AsI25nIW83HpRA+V3eKt54J2cnnGjEYS+v5Gu0PSyd31N/IoKRogXJE?=
 =?iso-8859-1?Q?A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1P190MB0830.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021)(8096899003)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b3cIs4HrBjOJeYlV427oxpL/F502fQWYv3kI+1rywPKi6ZLJary9atisuK?=
 =?iso-8859-1?Q?l0GFXsa8TXXiJgNLX65dIFUySrQnz5uMVWhG+sQ23lrBmM5rQCYA7goh8Q?=
 =?iso-8859-1?Q?EQ2YB455tHxKxHjCBI4z7uEdujOqxZRUhmeRsFtotz8HYlGhKkbVKrobNw?=
 =?iso-8859-1?Q?cBo96qMRjHhMHQZ6I4TbrDWKjQacXM1syaJ26XAV9DpLTFRsqWutzoYWVd?=
 =?iso-8859-1?Q?n3LkanokPm3mjvre/nYnk9mHNbhgGJF1q9RyvS5jSMf3oe96tI84Wrl+dr?=
 =?iso-8859-1?Q?FJP3V/7OKu+6otUlx5pb9KG7T+ff4On56Imn2zB8pZoBBLz/o9bUzqgV7/?=
 =?iso-8859-1?Q?H8882lSaQ/Q4ls3rB8nFNoji0FZ8pHePaTp9P/28FkwDoOWjY8FBOztDUw?=
 =?iso-8859-1?Q?NFaIDk+pAzmTT4kvuR2pYv8WnkRvU2MKerNYPpeldZPawmqGgcCRmv8akI?=
 =?iso-8859-1?Q?9Om3kNLO0k6fb8U9s7JRYWwAjQ6Qn3//GO8MD6oO8eWgM34N7aZn6Qqvgt?=
 =?iso-8859-1?Q?mdxHgxorbgPPadgsJFGtDAlAjUKaTclFgb1Mm2NjDCyZBUeiFRhg189D0d?=
 =?iso-8859-1?Q?c/ZAkAAg2o528DjQ3qn2HefP/gid9TyFMGcJK+kYhnSuW5j3tsusk7hEid?=
 =?iso-8859-1?Q?zFLwGbGV4gm/fmiG3GDChFF5iaQX6hFhm/Gf1ilYRa0ZwPZmmdtKKPQvD8?=
 =?iso-8859-1?Q?NqUtAjgXp+kxMTlTCRh+NdbV7Ok61+BZRnt7Sopwz7D+5MnGSlFMQsxA09?=
 =?iso-8859-1?Q?H2Wy85k3fHeGliaofvAowBn1puHzy9RGYBgdYg+7x1hzhArsLcSbajLQoc?=
 =?iso-8859-1?Q?nIf9y7pu5u/kwQwcuBBYUiztpLzVF871ZF87+/n/s+wblvN2Qn/FRuPecd?=
 =?iso-8859-1?Q?lStoAEmzLeds0b09XwdvNW+Is/Um4DjsrFohLi5OjRpYtbuORDclSma9ow?=
 =?iso-8859-1?Q?T6HlN0iZWwJCAyfKC/Nk8c2fNXkamnR+rNob+wqgE/XwKE0fBsBkAzbObD?=
 =?iso-8859-1?Q?jcsBYuZpXtP6IoaRkzndcx4BNgEp3QfZ5RRpXyTy68d7c4cxVVnNvjDtDn?=
 =?iso-8859-1?Q?2Zf0Rg0DJBdbW39ve5fq6SqrjzfMo46JiU/YnBPIddM03SbWwwdbSLTnMM?=
 =?iso-8859-1?Q?i8F/KQir5t/3Sa0zOxTqZa6MVFRuZGKsHMDRDbDjJg1QwdOpaYhkCJnKyv?=
 =?iso-8859-1?Q?CUn9xaQstOpH1i6y7JnR79etdA7v58ermPNG1BgP69FSdD2xzfq2s4ip5R?=
 =?iso-8859-1?Q?J5SIsxFiNUzWQxmnpnPUVi4c5Xs/lFxcCwjE64eZqzdCvWdQUXgQez7CiX?=
 =?iso-8859-1?Q?z/KgDqWnNS/f0SKC0jX+t3x12Oyv4Ap1s4XdfEiT/RRbz5xVoSgIKIV12e?=
 =?iso-8859-1?Q?rqbdKf1bBZuUKmA65jb+OTYxI4BkC/CvGtirOPfy8851hVR8ryGFWSOnBi?=
 =?iso-8859-1?Q?tUg7HBvDe4SEMN5mAv9MUDKUKIGwhWvbdZIOzdvkx4S9jGORm1zcWvMLo3?=
 =?iso-8859-1?Q?+FGWTkAIL8uIqzcDag/nFR6vXIZCDe7zAEE2kwAm6WnrboRpB2JX0xRxeu?=
 =?iso-8859-1?Q?sajSeHR6IlOTU/e3kiVXhIcY6r1ExLdNPt31ioxQOqgryeV2Q3c4BoCPzC?=
 =?iso-8859-1?Q?kEqRw2UYnSa2cBT95EdrEF6BkSNqKPRms4?=
Content-Type: multipart/alternative;
 boundary="_000_VE1P190MB08305B788F9E11C757A19CFB8015AVE1P190MB0830EURP_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P3souRuecGX7c/cCe1vaYanUooNR2oIpmV+gAIWWj5w7W7n/JgpDKkcANssWGfHkOuZg0Kdkq379pzK/U6Z6W+dE6R+X3wBVSeXSi8N0+k7dFrnBXSyuKOUW08GhlHiwT8tM3tIsGkhYEe6VCYbl2OJsAHAisdnKQ6uzN9+UP8us/Mf6QPraDMP+dEdhsH7fz69jymDx4YyA/KdA6nLGaMuVLFYw3yLaOS9d9rOZi8AfeCkg9AEz60cDdsHVq6WOXc43gaP82wnp1WOfXh1qeOmTG6ZRhgyikC/qneSDpIBRL5SaQ5Oh0laNyZJuj3uXZrDKavMTdGW/6VPzGVOAuI588fwvpHiiiELAI2AoA/aAHA2k5UJ8GV0ihpo2LJz1+SSNDQ0y4BSZ8RBBbZdbmSBP7BZe5F7QYI5WGFh1jTJM+dZge7hDlouNvyDiRAVDw9Zz+N7bY2hw0a05a3gHUJCKkMIJ/nJXUOAWwS1sorYhunTU3oGlesqAxonS6pxgUrbKZmz3qELg/yPxtVu89F1U5BlUB8Udrppp93EgckABYu8U31248ky4d3gs0avTFJVZijdsQuXSvWtLiBF5zAifvAmKjSVxCsNLBLXXYt7F+6oig52D5MEnoKGc8gtYuYT0C1aWcWuAj0DwuEf7tQWZdXNWdB3Uv6bSC3BTguU=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e573d450-c7ef-4e7c-9e97-08ddf4401f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 10:10:39.3104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kokQyqwI5qguPDJHtOOMB9O4kQ5GTie/I7LWVlzSh1ig0oXhMsBT3VR2o356xDojflTRmS59PEMdhZkghP/tLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1195
X-BESS-ID: 1757931042-303813-7624-1409-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.159.133
X-BESS-Parts: H4sIAAAAAAACAzXLOw6EMAwE0Lu4psgPj81V0BYOSUSDKDbFSoi7bwpoRjMjvf
 Wi+uu0UB850fmlhZ3IaPs40TQ6aZUFGzg4pDHVUmRfdG6R7un1ez8erwAen4tZq1aCef
 hSTZP5rMgpCDtj0P35A9AJuOeBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267505 [from 
 cloudscan21-252.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=HTML_MESSAGE, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

--_000_VE1P190MB08305B788F9E11C757A19CFB8015AVE1P190MB0830EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Stephen Hemminger <stephen@networkplumber.org>
Sent: 13 September 2025 19:23
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Mykola Kostenok <mko-plv@napatech.com>; Ch=
ristian Koue Muf <ckm@napatech.com>
Subject: Re: [PATCH v2 1/7] net/ntnic: introduce service API for NTNIC PMD

On Mon,  8 Sep 2025 16:17:33 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
> index b3d6ad70c1..a173eaa2ac 100644
> --- a/doc/guides/nics/ntnic.rst
> +++ b/doc/guides/nics/ntnic.rst
> @@ -185,3 +185,115 @@ There are list of characteristics that age timeout =
action has:
>  - after flow is aged-out it's not automatically deleted;
>  - aged-out flow can be updated with ``flow update`` command,
>    and its aged-out status will be reverted;
> +
> +Service API
> +-----------
> +
> +**nthw_service_add**
> +**nthw_service_del**
> +**nthw_service_get_info**
> +
> +The NTNIC PMD provides a service API that allows applications to configu=
re services
> +
> +The services are responsible for handling the vital functionality of the=
 NTNIC PMD:
> +
> +- **FLM Update**: is responsible for creating and destroying flows;
> +- **Statistics**: is responsible for collecting statistics;
> +- **Port event**: is responsible for handling port events: aging, port l=
oad, and flow load;
> +- **Adapter monitor** is responsible for link control;
> +
> +**NOTE**: Use next EAL options to configure set service cores
> +   * -s SERVICE COREMASK Hexadecimal bitmask of cores to be used as serv=
ice cores;
> +   * -S SERVICE CORELIST List of cores to run services on;
> +
> +**NOTE**: **At least 5 lcores must be reserved** for the ntnic services =
by EAL options. above.
> +
> +For example
> +
> +.. code-block:: console
> +
> +   dpdk-testpmd -S 8,9,10,11,12
> +
> +The PMD registers each service during initialization by function:
> +
> +.. code-block:: c
> +
> +   int nthw_service_add(struct rte_service_spec *srv_spec, const enum rt=
e_ntnic_service_tag tag)
> +
> +and unregistered by the PMD during deinitialization by the function:
> +
> +.. code-block:: c
> +
> +   int nthw_service_del(const enum rte_ntnic_service_tag tag)
> +
> +The service info may be retrieved by function:
> +
> +.. code-block:: c
> +
> +   struct nt_service *nthw_service_get_info(const enum rte_ntnic_service=
_tag tag)
> +
> +The service info includes the service ID, assigned lcore, and initializa=
tion state.
> +
> +Service API for user applications
> +---------------------------------
> +**rte_pmd_ntnic_service_set_lcore**
> +**rte_pmd_ntnic_service_get_id**
> +
> +The exported service API is available for applications to configure the =
services.
> +
> +By API function:
> +
> +.. code-block:: c
> +
> +   int rte_pmd_ntnic_service_set_lcore(enum rte_ntnic_service_tag tag, u=
int32_t lcore_id)
> +
> +For example to assign lcores 8,9,10,11,12 to the services, the applicati=
on can use:
> +
> +.. code-block:: c
> +
> +   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_STAT, 8);
> +   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_ADAPTER_MON, 9);
> +   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_0_EVENT, 10);
> +   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_1_EVENT,11);
> +   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_FLM_UPDATE, 12);
> +
> +The API will automatically lcore to service core list and map the servic=
e to the lcore.
> +
> +.. note:: Use `rte_service_lcore_start` to start the lcore after mapping=
 it to the service.
> +
> +Each service has its own tag to identify it.
> +
> +.. code-block:: c
> +
> +   enum rte_ntnic_service_tag {
> +      RTE_NTNIC_SERVICE_FLM_UPDATE =3D 0,
> +      RTE_NTNIC_SERVICE_STAT =3D 1,
> +      RTE_NTNIC_SERVICE_PORT_0_EVENT =3D 2,
> +      RTE_NTNIC_SERVICE_PORT_1_EVENT =3D 3,
> +      RTE_NTNIC_SERVICE_ADAPTER_MON =3D 4,
> +      RTE_NTNIC_SERVICE_MAX
> +   };
> +
> +The application may use next API function to retrieve the service id:
> +
> +.. code-block:: c
> +
> +  int rte_pmd_ntnic_service_get_id(enum rte_ntnic_service_tag tag);
> +
> +
> +For example, to enable statistics for flm_update service, the applicatio=
n can use:
> +
> +.. code-block:: c
> +
> +   int flm_update_id =3D rte_pmd_ntnic_service_get_id(RTE_NTNIC_SERVICE_=
FLM_UPDATE);
> +   rte_service_set_stats_enable(flm_update_id, 1);
> +
> +All other manipulations with the service can be done with the service ID=
 and rte_service* API.
> +
> +To use the service API, an application must have included the header fil=
e:
> +
> +.. code-block:: c
> +
> +   #include <rte_pmd_ntnic.h>
> +
> +And linked with the library: `https://linkprotect.cudasvc.com/url?a=3Dht=
tps%3a%2f%2flibrte_net_ntnic.so&c=3DE,1,Y0L6xj9VNKcZFYqAqRe-8zIt_7rMPD4KOWR=
MISoqVC_WIz7nsVj8xFm2zsiLl9o97z8bgkUxWD4uEioCtxO_S3AIO5hqm9inj17-Hase1qRv2b=
yMWjlBinC_4A,,&typo=3D1` or `librte_net_ntnic.a` for static linking.

It is not clear what happens if application does not use the driver API?
What happens "out of the box" with OVS and VPP?

The fact that it requires special driver API's shows that there is a missin=
g
feature in the service lcore library. Should be able to do this stuff throu=
gh that
API. But that is not your problem, and doesn't need solving in this set.



Hi Stephen!

I will add some details here. There is an approach to run any application t=
hat can pass the EAL option to the rte_eal_init funtion.
Only one option is required here (-S SERVICE CORELIST or -s SERVICE COREMAS=
K).
If this option is passed, then the ntnic services will be started with the =
function rte_service_start_with_defaults  https://git.dpdk.org/dpdk/tree/li=
b/eal/linux/eal.c#n1259 inside of the rte_eal_init, since they are already =
registered after rte_bus_probe.

For OVS it is possible due to option dpdk_extra.
For example: ovs-vsctl set Open_vSwitch . other_config:dpdk_extra=3D"-S 8,9=
,10,11,12 ..."

On the other side, the VPP has a "whitelist" of the EAL options, as far as =
I understand.
That list does not include handling service cores, so a small extension for=
 the DPDK plugin is necessary here to support extra EAL option(s).

BR,
Serhii

--_000_VE1P190MB08305B788F9E11C757A19CFB8015AVE1P190MB0830EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
<b>Sent:</b>&nbsp;13 September 2025 19:23<br>
<b>To:</b>&nbsp;Serhii Iliushyk &lt;sil-plv@napatech.com&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; Mykola Kostenok &lt;mko-=
plv@napatech.com&gt;; Christian Koue Muf &lt;ckm@napatech.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v2 1/7] net/ntnic: introduce service API fo=
r NTNIC PMD</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">On Mon,&nbsp; 8 Se=
p 2025 16:17:33 +0200<br>
Serhii Iliushyk &lt;sil-plv@napatech.com&gt; wrote:<br>
<br>
&gt; diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst<br>
&gt; index b3d6ad70c1..a173eaa2ac 100644<br>
&gt; --- a/doc/guides/nics/ntnic.rst<br>
&gt; +++ b/doc/guides/nics/ntnic.rst<br>
&gt; @@ -185,3 +185,115 @@ There are list of characteristics that age timeo=
ut action has:<br>
&gt;&nbsp; - after flow is aged-out it's not automatically deleted;<br>
&gt;&nbsp; - aged-out flow can be updated with ``flow update`` command,<br>
&gt;&nbsp;&nbsp;&nbsp; and its aged-out status will be reverted;<br>
&gt; +<br>
&gt; +Service API<br>
&gt; +-----------<br>
&gt; +<br>
&gt; +**nthw_service_add**<br>
&gt; +**nthw_service_del**<br>
&gt; +**nthw_service_get_info**<br>
&gt; +<br>
&gt; +The NTNIC PMD provides a service API that allows applications to conf=
igure services<br>
&gt; +<br>
&gt; +The services are responsible for handling the vital functionality of =
the NTNIC PMD:<br>
&gt; +<br>
&gt; +- **FLM Update**: is responsible for creating and destroying flows;<b=
r>
&gt; +- **Statistics**: is responsible for collecting statistics;<br>
&gt; +- **Port event**: is responsible for handling port events: aging, por=
t load, and flow load;<br>
&gt; +- **Adapter monitor** is responsible for link control;<br>
&gt; +<br>
&gt; +**NOTE**: Use next EAL options to configure set service cores<br>
&gt; +&nbsp;&nbsp; * -s SERVICE COREMASK Hexadecimal bitmask of cores to be=
 used as service cores;<br>
&gt; +&nbsp;&nbsp; * -S SERVICE CORELIST&nbsp;List of cores to run services=
 on;<br>
&gt; +<br>
&gt; +**NOTE**: **At least 5 lcores must be reserved** for the ntnic servic=
es by EAL options. above.<br>
&gt; +<br>
&gt; +For example<br>
&gt; +<br>
&gt; +.. code-block:: console<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; dpdk-testpmd -S&nbsp;8,9,10,11,12<br>
&gt; +<br>
&gt; +The PMD registers each service during initialization by function:<br>
&gt; +<br>
&gt; +.. code-block:: c<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; int nthw_service_add(struct rte_service_spec *srv_spec, =
const enum rte_ntnic_service_tag tag)<br>
&gt; +<br>
&gt; +and unregistered by the PMD during deinitialization by the function:<=
br>
&gt; +<br>
&gt; +.. code-block:: c<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; int nthw_service_del(const enum rte_ntnic_service_tag ta=
g)<br>
&gt; +<br>
&gt; +The service info may be retrieved by function:<br>
&gt; +<br>
&gt; +.. code-block:: c<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; struct nt_service *nthw_service_get_info(const enum rte_=
ntnic_service_tag tag)<br>
&gt; +<br>
&gt; +The service info includes the service ID, assigned lcore, and initial=
ization state.<br>
&gt; +<br>
&gt; +Service API for user applications<br>
&gt; +---------------------------------<br>
&gt; +**rte_pmd_ntnic_service_set_lcore**<br>
&gt; +**rte_pmd_ntnic_service_get_id**<br>
&gt; +<br>
&gt; +The exported service API is available for applications to configure t=
he services.<br>
&gt; +<br>
&gt; +By API function:<br>
&gt; +<br>
&gt; +.. code-block:: c<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; int rte_pmd_ntnic_service_set_lcore(enum rte_ntnic_servi=
ce_tag tag, uint32_t lcore_id)<br>
&gt; +<br>
&gt; +For example to assign lcores 8,9,10,11,12 to the services, the applic=
ation can use:<br>
&gt; +<br>
&gt; +.. code-block:: c<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_STAT, =
8);<br>
&gt; +&nbsp;&nbsp; rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_ADAPTE=
R_MON, 9);<br>
&gt; +&nbsp;&nbsp; rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_0=
_EVENT, 10);<br>
&gt; +&nbsp;&nbsp; rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_1=
_EVENT,11);<br>
&gt; +&nbsp;&nbsp; rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_FLM_UP=
DATE, 12);<br>
&gt; +<br>
&gt; +The API will automatically lcore to service core list and map the ser=
vice to the lcore.<br>
&gt; +<br>
&gt; +.. note:: Use `rte_service_lcore_start` to start the lcore after mapp=
ing it to the service.<br>
&gt; +<br>
&gt; +Each service has its own tag to identify it.<br>
&gt; +<br>
&gt; +.. code-block:: c<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; enum rte_ntnic_service_tag {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_NTNIC_SERVICE_FLM_UPDATE =3D 0,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_NTNIC_SERVICE_STAT =3D 1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_NTNIC_SERVICE_PORT_0_EVENT =3D 2,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_NTNIC_SERVICE_PORT_1_EVENT =3D 3,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_NTNIC_SERVICE_ADAPTER_MON =3D 4,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_NTNIC_SERVICE_MAX<br>
&gt; +&nbsp;&nbsp; };<br>
&gt; +<br>
&gt; +The application may use next API function to retrieve the service id:=
<br>
&gt; +<br>
&gt; +.. code-block:: c<br>
&gt; +<br>
&gt; +&nbsp; int rte_pmd_ntnic_service_get_id(enum rte_ntnic_service_tag ta=
g);<br>
&gt; +<br>
&gt; +<br>
&gt; +For example, to enable statistics for flm_update service, the applica=
tion can use:<br>
&gt; +<br>
&gt; +.. code-block:: c<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; int flm_update_id =3D rte_pmd_ntnic_service_get_id(RTE_N=
TNIC_SERVICE_FLM_UPDATE);<br>
&gt; +&nbsp;&nbsp; rte_service_set_stats_enable(flm_update_id, 1);<br>
&gt; +<br>
&gt; +All other manipulations with the service can be done with the service=
 ID and rte_service* API.<br>
&gt; +<br>
&gt; +To use the service API, an application must have included the header =
file:<br>
&gt; +<br>
&gt; +.. code-block:: c<br>
&gt; +<br>
&gt; +&nbsp;&nbsp; #include &lt;rte_pmd_ntnic.h&gt;<br>
&gt; +<br>
&gt; +And linked with the library: `https://linkprotect.cudasvc.com/url?a=
=3Dhttps%3a%2f%2flibrte_net_ntnic.so&amp;c=3DE,1,Y0L6xj9VNKcZFYqAqRe-8zIt_7=
rMPD4KOWRMISoqVC_WIz7nsVj8xFm2zsiLl9o97z8bgkUxWD4uEioCtxO_S3AIO5hqm9inj17-H=
ase1qRv2byMWjlBinC_4A,,&amp;typo=3D1` or `librte_net_ntnic.a`
 for static linking.<br>
<br>
It is not clear what happens if application does not use the driver API?<br=
>
What happens &quot;out of the box&quot; with OVS and VPP?<br>
<br>
The fact that it requires special driver API's shows that there is a missin=
g<br>
feature in the service lcore library. Should be able to do this stuff throu=
gh that<br>
API. But that is not your problem, and doesn't need solving in this set.</d=
iv>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Stephen!</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);">
I will add some details here. There is an approach to run any application t=
hat can pass the EAL option to the rte_eal_init funtion.</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);">
Only one&nbsp;option is required here (-S SERVICE CORELIST or -s SERVICE CO=
REMASK).</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);" class=3D"elementToProof">
If this option is passed, then the ntnic services will be started with the =
function rte_service_start_with_defaults &nbsp;<a class=3D"OWAAutoLink" id=
=3D"LPlnk880194" href=3D"https://git.dpdk.org/dpdk/tree/lib/eal/linux/eal.c=
#n1259">https://git.dpdk.org/dpdk/tree/lib/eal/linux/eal.c#n1259</a>&nbsp;i=
nside
 of the rte_eal_init, since they are already registered after rte_bus_probe=
.</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);">
For OVS it is possible due to option dpdk_extra.&nbsp;</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);">
For example: ovs-vsctl set Open_vSwitch . other_config:dpdk_extra=3D&quot;-=
S 8,9,10,11,12 ...&quot;</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);">
On the other side, the VPP has a &quot;whitelist&quot; of the EAL options, =
as far as I understand.</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);" class=3D"elementToProof">
That list does not include handling service cores, so a small extension for=
 the DPDK plugin is necessary here to support extra EAL option(s).</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);">
BR,</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);">
Serhii</div>
</body>
</html>

--_000_VE1P190MB08305B788F9E11C757A19CFB8015AVE1P190MB0830EURP_--
