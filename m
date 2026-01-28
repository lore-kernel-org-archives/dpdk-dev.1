Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3FCD3F09A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:11:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DB724026F;
	Wed, 28 Jan 2026 18:11:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id F416E4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:11:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769620290; x=1801156290;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=EK+nyxLFutMbmXecyhEx9ZIbJDuiPVP4iJ43lK7Jdsk=;
 b=a4fPrJovmS3tYn4i5KicwH+ynO2heZaE8pBcnXgMhqK3brcMWV5x/AEO
 /dh8uX4Oo5LupHlrCviyLSL4qm1zZ8yilpiUglrJc9iOH8LrAe8C5CveX
 mibcqgVXIS2LxTYSyoZ6yK/FCJ7eXwGcdbAyrS2j2ae3ER+4ohDQ2cnhN
 v2nf+LOVWT+bG1Mtp59PBin91dZNwyaFAMijJlwxtNCHf8sd+0hd0BHQ5
 t4IFmELCynK/lhLbypLvMGMfxbqlqdkJ9B3dOhIBpvSKI0YzOv6OcYGLV
 wf7HF+mO9jAN9R2/7LhqRvHoEo4oHVVLdJ2M5QZ/Oh6e+6/KRNYiNOIgQ w==;
X-CSE-ConnectionGUID: O8odFeb4SZeJlKp0k08nSw==
X-CSE-MsgGUID: psm4/MAoSg+Quf1nI/eh6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81953176"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208,217";a="81953176"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 09:11:29 -0800
X-CSE-ConnectionGUID: QhKZwBGPR9iZ3mmX5jpWsQ==
X-CSE-MsgGUID: GNkvb6iJRd6+cFLsPCuX4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
 d="scan'208,217";a="213191974"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 09:11:29 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:11:28 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 09:11:28 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.35)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:11:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXyG9aQ/nhBlpIX2ZpcXdJZfF51klbYWfm2VIIO6cwrD5MO6rZ+D45ayi64mh6AFz1xReVYYCrMQZP1f+6ueLkO3OcD4ghzoyDDLvNM4P09RgEkKZe/0rd9CWQOdytXw/xZExW1ff9PlTQa2tL6iuZheKTC6eb9+feKvv33SGeQmUuVn+t2/1l016IN9/L5JE9A2sUyZdTDWKHjYL38BB3WPP+Z2UIr1XQNcZ9khBNhqayj3FY1Y2q2q374qYu8rPn2PyLHpGekuhyA1WEenp38EIOBnQ9h0S3dOwD5XgcGHE+J1rWSWRqk8/p4CNkHcZo8V/8qbKsX4gJzSt7I9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQZeFemt4SK5UnJn6tH3b/EwMe2cKvX92YmwxBEkj24=;
 b=vby2U1oXePyoTTZdnbJzZ1WoNXX1HvEmxG+RB47t393tOW6YP6UnL5e6N1PSiR9T7pavgIfyHBsJ4cu7nltawuGiNx0/FfTXMjY0KkyXN9e32jrOZfwCNiaYq/yafgQ695HtYiMnrEphbbwEhbmmdTKG2jqTZsgUPnn70VcVtsK2Q+fNpE5QgYbXSrgkmO80dCIRiP07x23gd1rZ+0jBV0xEL+sGrGuAdqrC6WTib+5MxqgKFk/iyvShyBuihizn5qBPeVR8gHV8ZaJzWbya9v2/YXZWacuRQH0OhGosKVYG++PdHKiUEI43pxcugnOmpPjAEplZMs+lBboqvRBwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by CYYPR11MB8357.namprd11.prod.outlook.com
 (2603:10b6:930:c5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 17:11:25 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::bf1f:4648:d54b:308a]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::bf1f:4648:d54b:308a%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 17:11:25 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-01-27
Thread-Topic: DPDK Release Status Meeting 2026-01-27
Thread-Index: AdyQeQfbXPg3GGTFSbK2GoXMG6G7mw==
Date: Wed, 28 Jan 2026 17:11:25 +0000
Message-ID: <DM3PPF291EF9BF14293724890AC8C6AA91AFC91A@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|CYYPR11MB8357:EE_
x-ms-office365-filtering-correlation-id: 7923d900-fd6a-45f0-2ebe-08de5e9044cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9mN/yFMI26R03Z3pjBhda/CcjpDTeekc58QqL1Qmo1RXuIxDKf6T4QD/GgOs?=
 =?us-ascii?Q?uwcQ7xn3w9x5UmtVZXbqe/jrcConh2QLqR/GLfcg31Sk2ccdqvrV6fjqolje?=
 =?us-ascii?Q?xd+U/yDihf+QVQ88Cf9F7dbZqA4Z1TYAfcnCdTa/3ApBh83WjIyrBQdi90TM?=
 =?us-ascii?Q?6q6HJFTmhoaRfOYy3QUtFzxLpI47Jd8LBHHGRBj5JeteYKO1jXYpb7IHpo2i?=
 =?us-ascii?Q?5Nu1y3kkUkeDYCN27jiHnkNwg8QWvXc/50Zp6b/WkDONHmIJ07IN6fUms26C?=
 =?us-ascii?Q?RK7CUCOH6qTtiV39U0ChidwwehfuV2S928Mf3BshXDObYm9ctUW2rzjZq8o2?=
 =?us-ascii?Q?lZ3wKsNOcxBgDHEhT0Njsjp5po/ZqDAkdC1jcIWiNvSuxc937Z6Tf1etls9/?=
 =?us-ascii?Q?C81XnXM/B0lkZWfj58O4n8Urxhf7iCYqt6oLuiThSVq+7cgb6cCyGvoJhVA9?=
 =?us-ascii?Q?qIeU6yg5UZ2OlSl/WH+ArgMDk6TtTp2HTI08RR9wwESajdMQBcCF+5Z16dVc?=
 =?us-ascii?Q?yij1J9IOO+Ghv/iLlXveRU+H/zH5kWx4SXeL7ZtuLZfzC2YVujyIhi6Y7Z3B?=
 =?us-ascii?Q?k86lv0MLOuXa8QAUgNgZhkBAdz8KVuH5ArsxOTMTOJj4gi8bt7SVccfz6EPM?=
 =?us-ascii?Q?tNAKFE2TpOmxYva0XuCUiSM2eWefH7/6DZVwg7u9QfgeKhNIHutX5H2yRk7E?=
 =?us-ascii?Q?zhj+KIeBliwAFWwHDf5IlWNrxdmDa0d7S9m3EeXuigOctMPTK7ziweVcK2Fl?=
 =?us-ascii?Q?kAlweDOHI1OzAQ0h7N2wkIrie2DmbYG75R+2KyX2ErB1xZUqYTlR8JTYWz+B?=
 =?us-ascii?Q?gVIL5da7i2dHQVIdpso+LbDUaLxi2L+EI5KxxSs8SeGI9fh9ZOvYy3N3Uu1l?=
 =?us-ascii?Q?5Zs642iRZ9mG8KTmcqZQOX8/Gh3+rS3UzGi3REIe8a1ZPjRwAv40ER7S6RNi?=
 =?us-ascii?Q?8Hp6Vtph7G0UN0m0QXpnuXzzfVfzBmxRA9RyfGYbQsOpWqAbQ9qPwyTirRXj?=
 =?us-ascii?Q?OXli+f3cjlnaSPwgE4NF0kQTn2zdsZOIH6LXYIQZwd4a3HaigNOqWCaHSiVj?=
 =?us-ascii?Q?nuJYV46boeLO3wzKMKgU5Q2/FO3s0LtmoMW9CVT8ze7WuMYLQr1GcHVztGMV?=
 =?us-ascii?Q?A6B3uZ4Ik7kD9J+7Rq2MqMzTW4BtvWZNR0LJSB2+1RxFIBOKAnMKYwxYLsd4?=
 =?us-ascii?Q?IGMrGHI6gPXoNGoCjPnT9e9M694IPx5N3CbjPSxskqRNu+IVlX0DF3T1H9+L?=
 =?us-ascii?Q?b21Zq4NZ1WkMKNDz3w/OzSg6hraU405C408CKXsEEefz/15BEhYAtVF6NIm4?=
 =?us-ascii?Q?ZWft5q1Z4IERdN0QRT1waujOGNSXaihXaWNJqytBWfO/4GqY+mETfJNQtgmV?=
 =?us-ascii?Q?0OkxqrdDgWgpIYbW7DgNP91WTy0grT/+UT4ZW6LB+7BVAbAd0YMGXGc8xoto?=
 =?us-ascii?Q?XVIJVfWB6AVLJL5HT2iqUTwoSGsEI34YE/ciiumtif/BMM4Ay4mcNxroujoL?=
 =?us-ascii?Q?HhKhIc+PniLG7aJtRkDXNqVYlyey2BXlrR/Nj0PGysIy6cvlDEosTC9OW78n?=
 =?us-ascii?Q?BXhOjwJY3QtLAhRDtwAW8DglFy5nXeRkipavsISA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+WzAW8MsZxvIMt3thad0F449GoE4SseLxBI/RyXOLdx37JYCaI6eMxCuNnan?=
 =?us-ascii?Q?chLPF2GAOmQf61hVcGa4BJ7NLniQZeUcl+OnvFRg4eBmQLkbqVAfaGteu3F5?=
 =?us-ascii?Q?OYCMW0UDqW/mPELTFy3skwngTDPPqQt9VxRFwgWFfnJOuY/hJlqkLfO+T59j?=
 =?us-ascii?Q?QQSwf+QwShtU+NoFEsuYn5+qv9+OZo8LO2gcHMzHGHoVAiKdb+DpMNoa0VvT?=
 =?us-ascii?Q?Nu3VV7k/GEj0l4euoxoZRkC7IL0rbcaeYBh6RVYDxYLxuePx/Ce8VKHtQkuA?=
 =?us-ascii?Q?MA+Fn6vkvv0tdmetSRPTw19cwmib8HF8EmxeXvmjuCMy284kw+4mqnaPoDeK?=
 =?us-ascii?Q?MNozP3bYTfVIzY9o3bLBQD5GyHwRLTuyBn4oPYYO78WD3zsop+r2V35G6arg?=
 =?us-ascii?Q?D9EG4vNvnY6sfO8DPpWf1KNqYU4g+zYDBKJmOrnckz72aURwNV9zSLVGtCgQ?=
 =?us-ascii?Q?RTldgQ/6R87av9yvsBMZr84lR6iOp12XlPgcoB+u3GwM1KzCjRfYg+SxzsAn?=
 =?us-ascii?Q?hh4KvBNfQxfQ7exKlpvRZs9G2FFrRx05XA4GdAQiSEx+FABu7qruVVn0ai0A?=
 =?us-ascii?Q?fjip8A2WhpMP3dTznPM/SRubPGPJT8uh+EE193jq7rCDVrPmn0YUJjZLa7Xo?=
 =?us-ascii?Q?g4/jdC0nk0d4xI4RXqcO3I2SSIhrPLUKejifPKKyfix67ZkDJDsco7C2We6T?=
 =?us-ascii?Q?r9Ze8MTP2EoTHEDIUagM+tL29iBMldeN0YR46S9L/Ztqtrhn+QZf44qJ9XMq?=
 =?us-ascii?Q?lYNBEjGD1S6qsXqpfgTnuyZLf8Fr4hLknwfhE+b6FpTyj9xbmAqJUj+wIrDR?=
 =?us-ascii?Q?5mx4kKUTUMeVmTsZElQDlEl5YsiELubrzQ+xXBpW7aATnx7gk+R2iegUw+Li?=
 =?us-ascii?Q?ULBF0f+HW87yOzl17FzpiI7ujLQ8PMRuizoijZfcDocs0COb4sItJq86HE3E?=
 =?us-ascii?Q?S0/PuvM14WedD1B4UTOnF7d19xk56ZW6+2ix97MfkJx6Dh3MABDVJGFk3ugN?=
 =?us-ascii?Q?+/y9D1GzhVRZxUtWKc+sjQDDxqE8wagRxCe0NprD4e3kKbVzcgPAcuHVN+cP?=
 =?us-ascii?Q?gfs8PCyyxUk9B6Igz0/Ux8kK7+R1wKU0j/OfNJJpUbwealOZnbgAQ8ErQjJp?=
 =?us-ascii?Q?TrS47SMs4ghuFrrL7aZ5b1aFOKNTnrgJzes7jlZcBYU95GsBRwe2/1jzSk+Z?=
 =?us-ascii?Q?MpB2fuy2KKtPvkoh+JFvp9hnxffYetGomzFB+b6VeSf2ND0/ptix6cwlFSiY?=
 =?us-ascii?Q?hMSqPOEGgmfToDe0BNZMR/WxpZPDgESjTtoKyasNHTdjivPSVqXLqejy5gE2?=
 =?us-ascii?Q?u+n98l7Rxiakjo8sYGi3hXp0LtWVUoePfkecRglGgLO+RwYSG3ge7X2n9clM?=
 =?us-ascii?Q?UetpwCNcaJecmEGGgwv+YfGF7tfQQtEyfa5J7MmY2hiyGMKB60XkvhGjEt+k?=
 =?us-ascii?Q?WGE385gln3Bu8t4VI7/+0ex9m4/C/vKiexGrof/znFIyNbRJ7ZOu2Q0p0kES?=
 =?us-ascii?Q?aXpdp7RgyF35uOtsTUX/aA/xinTLrVklNrJ9tmwNlEza0Z1XMfCB55p8ns5x?=
 =?us-ascii?Q?aO5n4akHgcCyFXox2K9F05oqA0ldDNB5ZxcNH1jia88BD5aIszNjrhv+kToa?=
 =?us-ascii?Q?HjlbhXw5wj9Fc7ggjqdJjidRDqEpiVPMLLNQpZnWcXa3V32SRgtX9sxhNPvZ?=
 =?us-ascii?Q?d0a7nlyiEBL3bTeVptPxhXctHQn6yEuYe6yKLXHgjL1ejAkGp19A8uvzDCUT?=
 =?us-ascii?Q?xdqJ8oAJnw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM3PPF291EF9BF14293724890AC8C6AA91AFC91ADM3PPF291EF9BF1_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7923d900-fd6a-45f0-2ebe-08de5e9044cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 17:11:25.5081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDEbKcK6kX1Qn+K1JepPSGVf08IebyR0Wq7gUIHVaInoF+fb9VpxZzXLq1e91x4ZejTyL9B7CZJ9Fgf3m3dH+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8357
X-OriginatorOrg: intel.com
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

--_000_DM3PPF291EF9BF14293724890AC8C6AA91AFC91ADM3PPF291EF9BF1_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-01-27
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
- Release Dates
- Subtrees
- Roadmaps
- LTS
- Defects
- Opens

Participants:
- ARM
- Intel
- Marvell
- Nvidia
- Red Hat

Release Dates
-------------

The following are the proposed working dates for 26.03:


| Date            | Milestone      | Description                    |
| --------------- | -------------- | ------------------------------ |
| 5 January 2026  | RFC/v1 patches | Proposal deadline              |
| 9 February 2026 | 26.03-rc1      | API freeze                     |
| 2 March 2026    | 26.03-rc2      | PMD features freeze            |
| 9 March 2026    | 26.03-rc3      | Builtin apps features freeze   |
| 16 March 2026   | 26.03-rc4      | Documentation ready            |
| 19 March 2026   | 26.03.0        | Release                        |

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - No updates.

- next-net-intel
  - 30 patches applied.
  - 45 patches in backlog.

- next-net-mlx
  - No update.

- next-broadcom
  - No update.

- next-net-mvl
  - Working through backlog.

- next-eventdev
  - Working through backlog.

- next-baseband
  - No patches yet.

- next-virtio
  - Prepared branch with 4 patches.
  - Reviewed 2 patchsets.

- next-crypto
  - ~ 20 patches in backlog.
  - Zuc and Snow 5G algorithms introduced.

- next-dts
  - 1 patch for main.
  - Some other patches under review.

- main
  - Fixing issues from previous merges.
  - Unit tests patches merged. Some random failures.
  - Will pull next-net this week.


DPDK Summit CFP is open: https://events.linuxfoundation.org/dpdk-summit/pro=
gram/cfp/


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 24.11.4 - Released.
- 23.11.6 - Released.
- 22.11.11 - Released.

Older releases:
- 20.11.10 - Will only be updated with CVE and critical fixes.
- 19.11.14 - Will only be updated with CVE and critical fixes.


- Distros
  - Debian 13 contains DPDK v24.11
  - Ubuntu 25.04 contains DPDK v24.11
  - Ubuntu 24.04 LTS contains DPDK v23.11
  - RHEL 9 contains DPDK 24.11

Defects
-------

- Bugzilla links, 'Bugs',  added for hosted projects
  - https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.


--_000_DM3PPF291EF9BF14293724890AC8C6AA91AFC91ADM3PPF291EF9BF1_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2026-01-27<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Marvell <o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 26.03:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| Date&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Milestone&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| -------------=
-- | -------------- | ------------------------------ |<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 5 January 202=
6&nbsp; | RFC/v1 patches | Proposal deadline&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 9 February 20=
26 | 26.03-rc1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | API freeze&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 2 March 2026&=
nbsp;&nbsp;&nbsp; | 26.03-rc2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | PMD features =
freeze&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 9 March 2026&=
nbsp;&nbsp;&nbsp; | 26.03-rc3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Builtin apps =
features freeze&nbsp;&nbsp; |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 16 March 2026=
&nbsp;&nbsp; | 26.03-rc4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Documentation read=
y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">| 19 March 2026=
&nbsp;&nbsp; | 26.03.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Release&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 30 pat=
ches applied.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 45 pat=
ches in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-broadcom=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Workin=
g through backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Workin=
g through backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No pat=
ches yet.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Prepar=
ed branch with 4 patches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Review=
ed 2 patchsets.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - ~ 20 p=
atches in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Zuc an=
d Snow 5G algorithms introduced.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 1 patc=
h for main.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Some o=
ther patches under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Fixing=
 issues from previous merges.&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;- U=
nit tests patches merged. Some random failures.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Will p=
ull next-net this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Summit CFP=
 is open: https://events.linuxfoundation.org/dpdk-summit/program/cfp/<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See also: https=
://core.dpdk.org/roadmap/#stable<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS versions on=
going/released:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 24.11.4 - Rel=
eased.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 23.11.6 - Rel=
eased.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 22.11.11 - Re=
leased.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Older releases:=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Debian=
 13 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RHEL 9=
 contains DPDK 24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_DM3PPF291EF9BF14293724890AC8C6AA91AFC91ADM3PPF291EF9BF1_--
