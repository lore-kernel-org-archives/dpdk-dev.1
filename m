Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18DFCCD1A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 05:37:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D33140268;
	Fri, 24 Oct 2025 07:37:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
 by mails.dpdk.org (Postfix) with ESMTP id ED1F940267
 for <dev@dpdk.org>; Fri, 24 Oct 2025 07:37:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8Fqbz9N8AUj1cbI94d8Sti6y1iRh4tL2d3Cus0MKJSC3lxbNMzQA+MmDdzj+QXUdH0xWo9Qm2S6Ym2BrU/ztBLQPx8zdmb0JtADun+Rxsx0zpblQggGqScdlvxwIvS815Sh3SHH9ykIyDjpOFVZNp61HGmcL9sypONx4AoJ2CHcQe8woH2FmAp6eFYuIDkOB2Ey3m284y+fgZHwRI0BY/FyKK5vWHIfvI2SSfHsFFY9cOFaBIjUUAH6PQnVP5Vls90v8pUOqgkBQAjmXyNpUD4oMsNKKR9gQ8DwCLb5S81Fxz+fvBQywVY423gKz4IaVzrbEY0VIoRV9RiPDWTzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfTdxto/4NvUamQ1Bf/0HkcVMv93Nc9pxARffUiH/d0=;
 b=pQgmSBFJrmNTHSnhaR7mA8euJo3Du9sMsl4Eha9zP2yqHKXCoQvJW0+WBCtEZcxLejD7N7qSLrDNdO7/6CCzZN7uOy3bndHuVPmcUUa9NO31VqWTqmFc9nSD1Ab4SqrFD9wROLVkS4ydrtTRFfbPwPShTGhQ/jzchgfdlTecB4MrVxvo9cI+xyMh6XaOnErb5NTnhs8C8aj2vpucseg/k6onuHe2FOYuqAA7qhMt27Q6T7gNLCvsDLm3idD+2Pqe8z6yD2j5xiR2F7zK6TceR6HrEDhvOYhAaVv177zIdOp3oIpCo0Y3IsoSn2KLUxxvvtEe1ljpl8hVkQ/xe3lZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfTdxto/4NvUamQ1Bf/0HkcVMv93Nc9pxARffUiH/d0=;
 b=B2JHeYZGPxjIwk8LPGoVCJXS9T9SZWsxO9jy6CWm7wft2RFEljpSBkQrkMYzF6cCDsd0Pk8/tHURgOYBTB9Jrhba2o7hTV1Uc6SeY3pT4tT+g5wejDtLp4QRIHB2itmJA5zaPVIoMPLjuStb1Ncta5XTYW0ZYNQfCg5qLj/ZK9Wd2N1xsBhWGPMW9vsZwhNrahIxMQkBcV3zm1DpbyMavTjITtkyjKMGjyqXKFOpIjMKWBsl2LVckRVbP9y+nSroxZXJRvWC0YkiKOQXhfA/z3gw8qiHh8OBoxlTEI44b0x4o2b2WWLoBvYYhBJN0p5lE50yRcC2YeULHNv3v6GO6w==
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM0PR04MB7042.eurprd04.prod.outlook.com (2603:10a6:208:1a2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 05:37:52 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 05:37:51 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: RE: [PATCH v5 5/6] bus/dpaa: Set max push RXQ number
Thread-Topic: [PATCH v5 5/6] bus/dpaa: Set max push RXQ number
Thread-Index: AQHcPyFidJQG0gZT7U6BsWs3GkZT2LTHJX4AgAmpprA=
Date: Fri, 24 Oct 2025 05:37:51 +0000
Message-ID: <AS8PR04MB81985B5FFE7BEDE7C819DD7CE1F1A@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20251017044256.3264737-1-g.singh@nxp.com>
 <20251017044848.3269627-1-g.singh@nxp.com>
 <20251017044848.3269627-6-g.singh@nxp.com>
 <20251017185236.05ba6d9b@phoenix.lan>
In-Reply-To: <20251017185236.05ba6d9b@phoenix.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8198:EE_|AM0PR04MB7042:EE_
x-ms-office365-filtering-correlation-id: 60109b00-5281-410b-8599-08de12bf797b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2pxqe2R81vmUMRiYW6J1H6mg4uAFy1yEHIpeTbpChtMxdjlGwwbOJgMYvTSj?=
 =?us-ascii?Q?Wbk2IZH4tPfrMDcoJfpxHVKeZlQPy9bCl9PMkzvjiPdfNg97S7JSFayKsXiY?=
 =?us-ascii?Q?hHyCQsI7V6H1EDbrDd4hNsH6Vd7sZE+z0W1RChafj3DfSfZiiehZRkKJGY68?=
 =?us-ascii?Q?6mcCsrLBGZGePGZM3xoNt0yOlWTXtuZnJVhv/81nzvYnNG1D6ZhK2qbI8iJm?=
 =?us-ascii?Q?VeoLjYO+5kBcLY+4txX0vM2b69eMHUIUvWWr7ToeX8Ym9Beuvp80HeneFc1Y?=
 =?us-ascii?Q?VX9f7bxrE1wscTy5XGNnIldKFbDBO0eb5vsz/kKrxZEXWMGTf9tOlLrWxVZ5?=
 =?us-ascii?Q?O2YC/Ln3do5k+IPzIkmqRPjAd0N5yK8ODsZLtIiWc+yMCgT1dnuXADUOYr8j?=
 =?us-ascii?Q?cZRXZPkqcQqnCSVNjkzsrIbDEqQ94Wqar9UyFpCf2F6sCndEA6RbGeksgcLU?=
 =?us-ascii?Q?c6IUeh0n/LKQSYELpK1h67MjcBPX4Txy22wmLSnvdBGvlLF6QHW56UOZzIYq?=
 =?us-ascii?Q?UDPBstJsdgPIqxT5OQJNaY+gydReWcz9GZ2x2CcYMrDUP3E1DhVjV+lc4+DC?=
 =?us-ascii?Q?M7mjBfK2rfyizFrWGgYwFsCmKbZPdlxbXCVlcD2+90LlnUoFOeHKR/rqEQHf?=
 =?us-ascii?Q?qpColtHqPQp4DX+mO1WwPYXFgDjWhm4vzYyCz5rjSz7ZVl0Yae686ziQmKwo?=
 =?us-ascii?Q?x1MK6iH//hbVMFHxlX+7tt9czQt0xzIswvzYy5CAy3Tkyh5aE/uLFqhiY+mh?=
 =?us-ascii?Q?nHdtbkUS/LTjeXO1TliA7ywcxuSpQSBthxkunsrbklJr5/4YT8q/9io6LFD8?=
 =?us-ascii?Q?TJlEBEAvS3GztPkPDS8N8JlBlQ3H2dyjdcWlbcfgmmFtNIJ2/pCHXsCR5VUq?=
 =?us-ascii?Q?4oxf5NsGgp5OP5euZgFl2uZKDHR2Dy5qsH+4pMd9Geb1chrSBuLhE73nwB+l?=
 =?us-ascii?Q?ObQOpgRKj7Lxgb/uCCJq3XN8kbkVfGMyDpAxowcahZG+0LHraF7cgX010Pna?=
 =?us-ascii?Q?87tjVRylKlHUsfduQyLF8T7nIZ3upJSBaj2g6+YY9QP9Hn92T3dCAImZHngy?=
 =?us-ascii?Q?NDVbJ+ysfZqhdUNgyBV1VqgGo+ND1gWDnQn30a86fy7nF9LyM7rR+oNwTmhr?=
 =?us-ascii?Q?s/Ouxo56s5t76S0/3u4s68Wsdle5OG+29nZHFw4FvxlTBBKkay5UyGG03ds6?=
 =?us-ascii?Q?fVtctEhX4vUmSJv78w8JotSgqdFbAOKTkPg9Oi9tqSIFhD5F8vw+SSscPtzh?=
 =?us-ascii?Q?uyAjPMcK1DMx5Dag+H+Z9fXXVDTwyTjtJI/3KkOQH5XM4qo8M915p92X3ohV?=
 =?us-ascii?Q?ckPWOnbroUDY/vi88+P4UwmvIlQ+z5lBQwoR7+XgqDyVa2PUAsErG0SLc3FM?=
 =?us-ascii?Q?lG864mFeQ7fFF7T18sv8f0NHyYFWmEBEF/wybSt5bA66yG+FmARP3dGDv/Hu?=
 =?us-ascii?Q?C2RfAXKZbJt8Rj/qf1LH1JWacgGltrSQuAZjDJdpcGNhDInVPmGzkTOXdx0l?=
 =?us-ascii?Q?IKvzxunFYPW22XuOwCYjxRYvxDKRS47ndy8O?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NiExhZwB/50W0Ca1mh3Ill/YBG2rJg0X94Y1VHQRuv0EFkVMARGbeJ0h8W96?=
 =?us-ascii?Q?YghxfBhwggh7veWpnqScrImKXptqWeeMfyc6KQn+tbLg86NYLgljF0OjVZQ1?=
 =?us-ascii?Q?BdEAoFQSaxmbukZQ5IRhO31ekVzE238fSd3zdHZqZdy0EHRBxTV2SIoaLWdZ?=
 =?us-ascii?Q?g4yj0f/qhHABAcTkfwxOtv2EKvLsVlEkDAB7L0d2kBJMulZnT+xWZQRVZhRw?=
 =?us-ascii?Q?/ZGzXszJUNoBymNOFMwQK3DYQw1Vp7A5y5AsArNS9p5Tb+c0AGzhiIOJJrn9?=
 =?us-ascii?Q?zJxgb063YOnUI98TiyAQyQ6qLrDmO3zZNCo9EW5ra7pKpAVLIumNrjofMMYb?=
 =?us-ascii?Q?gY4TQoAFnUiSblV1MlQ1BSzdK+wLXGV+XInOo0xCPdjRb2fIdp2Si4IqAuYR?=
 =?us-ascii?Q?eVwJTxaF2qWXxVaCiU6fXk/3eHDVwmVssxtSKee+K3cuuyQoqqyiEv12BlHe?=
 =?us-ascii?Q?dpGjy7WfNaIyn0Ps+V4EkQUUxEMhJoFpkLSfRDJQLEWwSdyImzrFFXGDrfOk?=
 =?us-ascii?Q?Y5c2TzwgM5Z2Ky8yxT37buD+SkeyPZEIl9u3oK4z0AbDkTIFs2MbSA1bllkx?=
 =?us-ascii?Q?sgjuaMdeWeXp8k6mM+BmloOVGL6DuSHWP6/KHgG8EFxFW2P6fMRScASMM5z8?=
 =?us-ascii?Q?D/bLmCE/2ljTbEUUyp0ux9dgqOS+HZKpCjtHSPrGMt4Tv9snTxXWwh9VJeDv?=
 =?us-ascii?Q?/ubd79FdgaBxLXZCd29TxW356jMe0UqAZNDu3NXZoZ+1mLAQbYm+GpRpCrWu?=
 =?us-ascii?Q?0Gub4k07fhCZQKuDd3DQY0L7nB3eYz0jzDOf9AheRqeYTOV9kBDCynMpVX8+?=
 =?us-ascii?Q?2AsHv4xVQptgalQ3ncs/w5wVZWrlBFUrfpymFCiuXqDaZN8odlmgjMtcTmCg?=
 =?us-ascii?Q?Jr22MSO+ZdbrR/jPpDGI10Q0KYbHfflQ3014VgCAbCWJuLG+34Fu1RQKUjGi?=
 =?us-ascii?Q?0ihCMXri9Cv8nKfaFZkVijTtIyFvg9VE7mmsRza0SSiFhcb4N9P+AlGaXi2V?=
 =?us-ascii?Q?X+MDpoo1fU7wtASv75dMZjMWJ9DAOHbFHrAO5WDdHMpvs6rD69GSlIEPQIdf?=
 =?us-ascii?Q?lBrd+zb37s+CtUA7acvEKhSp7FRGBhsxf+DhvD5iaYefxPJopRVvAPjbU+vE?=
 =?us-ascii?Q?7ACfUF4KaqpyfpXat5QlzoDEje6tRCOEXwn8uw/FOSJrEXMjWiAAX0YiJK3e?=
 =?us-ascii?Q?KBNCmqfx32B8ZhurRDYyb5ANpSkU5UoOFMNlL7soGq1voUS5avA7WH1qDbAj?=
 =?us-ascii?Q?FDo4e9nvoJcc1BwYMmTPt1v9WMGWJ/4/RwQXfEbteID4qrngUkLHO43XJh92?=
 =?us-ascii?Q?Ab3mvMIWHAgeaRTDkK3OFRVPOrlk4vl5FWN0fh9GOQrfupz5zU7E5hvS5WhQ?=
 =?us-ascii?Q?EdDIAIph0fTxmVQvd+iw3CvK5HL1i0bLKrjW1juxU8AIf6GC9Pyr1QrDs6fk?=
 =?us-ascii?Q?zE8zx4IAFZPHvdoo9zmxFXCAEWF9uqSId2NlyFEvVB0lMlWNZOMDhIZU5hYb?=
 =?us-ascii?Q?J2D5mHQn0aPChmSoYkOnut+/91S3aRAsvQRMcIa6hjcXDESc226UJ/kkE94T?=
 =?us-ascii?Q?wmDJOklIA7ZUtvm/PG4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60109b00-5281-410b-8599-08de12bf797b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 05:37:51.8997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ztt54wmyQxvxoUxMEDgP0pv887N7soCTSee2Y09kH32PinSptynPGiLcBDpTpU0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7042
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

Hi

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Saturday, October 18, 2025 7:23 AM
> To: Gagandeep Singh <G.Singh@nxp.com>
> Cc: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
> <sachin.saxena@nxp.com>; Jun Yang <jun.yang@nxp.com>
> Subject: Re: [PATCH v5 5/6] bus/dpaa: Set max push RXQ number
>=20
> On Fri, 17 Oct 2025 10:18:47 +0530
> Gagandeep Singh <g.singh@nxp.com> wrote:
>=20
> >
> > +	/* Disabling the default push mode for LS1043A */
> > +	if (rte_dpaa_bus.svr_ver =3D=3D SVR_LS1043A_FAMILY) {
> > +		rte_dpaa_bus.max_push_rxq_num =3D 0;
> > +		return 0;
> > +	}
> > +
> > +	penv =3D getenv("DPAA_PUSH_QUEUES_NUMBER");
> > +	if (penv)
> > +		rte_dpaa_bus.max_push_rxq_num =3D atoi(penv);
> > +	if (rte_dpaa_bus.max_push_rxq_num >
> DPAA_MAX_PUSH_MODE_QUEUE)
> > +		rte_dpaa_bus.max_push_rxq_num =3D
> DPAA_MAX_PUSH_MODE_QUEUE;
>=20
> Please don't use environment variables for configuration.
> We have devargs for that.

We have not introduced any new environment variable, It is just moved to an=
other place.
