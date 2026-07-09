Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74BEC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 09:51:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B4BD402BB;
	Thu,  9 Jul 2026 11:51:55 +0200 (CEST)
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
 by mails.dpdk.org (Postfix) with ESMTP id 030524028C;
 Thu,  9 Jul 2026 11:51:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=2159; q=dns/txt;
 s=iport01; t=1783590713; x=1784800313;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TiXM1wJw6FJzlbtrdUIQbdM18b6SVlgHTTkYqRKLcr4=;
 b=Itm9D7QRUQckdKZs9sDvCA+3LteZ/UceH875UT0EiUhIBBfG39MuBt1e
 0cS6zSUEckAQHFcs3ieShtTWqJstDZHvF7DWF5FLHUEGMJeUvjb3on7Vv
 HpatLpjT+a5xMq0hT0K80B54bM9NtDE1BHR0r2L0tKmDf/QZW/1o5xiLa
 3Efxu1OjUO92fxB7LIeB+SevGnC23wv4LlqmSzq1txrgT8GaZqsJoW5I6
 OXxzbZS8caIZmX3aH8gDFlwcE4jiivBy5wN15Ond3xQQ59kaqm7htOtmS
 +uxu2QlJx3tO+WmAgQ5cg7B9T7lbZD24zxbsEMHEjTOHOUMPUBP7ELn02 w==;
X-CSE-ConnectionGUID: a+SOjVaqSiWZhsABLVYwig==
X-CSE-MsgGUID: XwsTCxrpT/2RfKEcPWIcsg==
X-IPAS-Result: =?us-ascii?q?A0A6AAD3bU9q/40QJK1aHQEBAQEJARIBBQUBZYEXCAELA?=
 =?us-ascii?q?YFtU4IrSYgjA4RMX4h5A4tkkjcUgWoPAQEBDQJRBAEBhQUCjU0CJjQJDgECB?=
 =?us-ascii?q?AMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGXIZaAQEBAQMSFRM/DAQCA?=
 =?us-ascii?q?QgOAwQBAR8QIBEdCAIEAQ0FCBqFGwM2AwECrFYBgT0Ciip4gQEzgQHdRg2CZ?=
 =?us-ascii?q?BQBgTgBhT6CfB8BAYQ8gSFUhEEnG4FJRIEVQoJpPoIfgWsgG4QTgjAEgiJ6E?=
 =?us-ascii?q?pFlUngcA1ksAVUTFwsHBYEjEDMDIAovLQIUDSIPBBYFLR1wDCcSDx0XFh5YG?=
 =?us-ascii?q?wcFEiAqQUUjAxoDUzEQOAtDBYFZAoIITiMfAzl/gTB1SnktgQABAhAeCmxCJ?=
 =?us-ascii?q?IIWAjoDC209NwYOGwMEgTUFjTUXD4I+AXoTgS8VOX2TFrJccQqEHZtfhjIXq?=
 =?us-ascii?q?myZCCORcJFuhRcCBAIEBQIQAQEGgWg8gVlwFYMiUxkPoWABvnx5PQIHAgcOA?=
 =?us-ascii?q?wuRaIF+AQE?=
IronPort-PHdr: A9a23:D8+xnRc3EUGpfuaUZZeSu3ztlGM/gIqcDmcuAtIPgrZKdOGk55v9e
 RWZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NCBo
IronPort-Data: A9a23:TXmDb6h8TOtcOmcQkkJgThR9X161NBEKZh0ujC45NGQN5FlHY01je
 htvC2yGM/aPamWmedkgaY23pB5V65HWndZjHlBkqi4yFy5jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeCULOZ82QsaDxMtPrT8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqURud1QA19H7
 McZFwINdTmpo9yH37O0H7wEasQLdKEHPasWvnVmiDWcBvE8TNWbH+PB5MRT23E7gcUm8fT2P
 pVCL2ExKk2eJUQTYz/7C7pm9AusrnnudDtbqVe9rqss6G+Vxwt0uFToGIWKKoXVG50FwS50o
 Er24H/FKQEALODYkwCL0V+nvtDuljj0Ddd6+LqQs6QCbEeo7mAeFjUaTVe45/6jhSaWQM5WI
 UgZ0iY2oat081akJuQRRDWxpHqC+xpZUN1KHqhitEeGy7Hf5ECSAW1soiN9VeHKffQeHFQC/
 lSIhNjuQzdotdWopbi1rN94cRva1fApEFI/
IronPort-HdrOrdr: A9a23:we4d36BjHOfztlflHeijsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskduZJhBo7y90KnpewK7yXcH2/hhAV7EZniohILIFvAv0WKM+UybJ8STzJ846U
 4kSdkANDSSNyk1sS+Z2njELz9I+rDum87Y55a6854ud3AXV0gK1XYBNu/vKDwMeOAwP+tAKH
 Pz3LshmxOQPV4sQoCQAH4DU+Lfp9vNuq7HTHc9bSIP2U2ltx/tzKT1PSS5834lPg9n8PMP4G
 LFmwv26uGZte2nyhjT7mnX755HstrswNlOCaW3+4kowzPX5TqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1iQGF4Xii7B8er1vZjXOIi3rqpsL0ABggDdBauI5fehzFr2I9odBH1r
 5R1W7xjesUMfqAplW52zH7bWAsqqOGmwtlrQfVtQ0HbWIqUs4UkWXYxjIMLH5PJlOg1GltKp
 gfMCiV3ockTbrdVQGYgkBfhPqxQ380AhCKBmIGusCTznxquUoR9TpD+CTa9U1wqK7UjPJ/lr
 n5G7Utm7dUQsAMa6VhQO8HXMusE2TIBQnBKWSIPD3cZeo60l/22tfKCY8OlamXUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO9hzWWm2yUTnk18kbvvFCy/DBbauuNTfGREElksOmrflaCsrHW+
 yrMJYTB/P4N2PhFYtAwgW7UZhPLnsVVtETp78AKhizi9OOLpevuv3Qcf7VKraoGTE4WnnnCn
 9GRzT3LNUo1DHcZpY5ummnZ5rAQD2KwXsrKtmpwwE68vl5CrFx
X-Talos-CUID: =?us-ascii?q?9a23=3ASoIfs2p8yNeOTh7Hhnx/svzmUclmSVrf8n7JGE6?=
 =?us-ascii?q?HO2ZyYZexd26P+awxxg=3D=3D?=
X-Talos-MUID: 9a23:ETkaXAYxQj08IeBThyD3uBpyLt9UpP6UBmMgmq05msKfOnkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-04.cisco.com ([173.36.16.141])
 by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Jul 2026 09:51:51 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-04.cisco.com (Postfix) with ESMTPS id A81E8180004B9;
 Thu,  9 Jul 2026 09:51:51 +0000 (GMT)
X-CSE-ConnectionGUID: 1r6jq6KnSD+4CWmc9wP/RQ==
X-CSE-MsgGUID: Lzhfo8PfS0yZk9ZR5XVQ0A==
Authentication-Results: alln-opgw-1.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="80335976"
Received: from mail-westus2azon11010069.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.69])
 by alln-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Jul 2026 09:51:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhxWOUmJ3krJMygJ1kQ0aVPG0BUZJ/ocb3UGOQSe7xUvHcBWCY6H8MsGInciIYshKqy8SkuzbPx0odz5ZeMlClV8zNuAkk3NCcHz4ABSGoFIYKKMoNw2DOzp1ZPiL9pLjQgK7m3N3EAI9PxXq2UsTOK2J78qj011ywLKsYgVYF4O/tIozzsJ9wJkDTjIUFojOOCNBS0pgdXWmB0H1cmI4IYCKZ7co+69rbatJGBrIufU2YQ0ujZrk+Kp6wYYwLRtBcliljlxsJd8Y8pybVXKnf0sOgXvS3ke0HnP7q6MI/hv0ZN303QT07462NEpIYRbBC5UkKQL1YmNnSgOvEu7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiXM1wJw6FJzlbtrdUIQbdM18b6SVlgHTTkYqRKLcr4=;
 b=AJRNujG16uBed5s+vvXZC2KxuRXRWzy+kNzeKOtAmqhlT5a4fyCLkqMQmMVXbsdGTQYxM8Vrzo80EJVkpXSbqYyW4S6SfbYBD9yLlog4rNvbdz1E+wxKl1HKdxdcnJ3xJx/zHIs89/wxxlUv+Yh1VHfjxtIlRNL18cvvastSAi4lFgFryArKy7p0992TgTSv+CiwvdqGCCJTJ/RgFxyitFG+ZABqpdeTn30zs+yRiOKxlWhUpB2G5j/YZqRNT6QUBiGkffP8gSyj2w/kAds87laZv9ZrIQGXtcByasMx2C8GBIvrJJ9Zxkt7sKUWVaBqJ2FN0Nh14WhtSWVNybiCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18)
 by DS3PR11MB9671.namprd11.prod.outlook.com (2603:10b6:8:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 09:51:49 +0000
Received: from IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925]) by IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 09:51:49 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Alexey Simakov <bigalex934@gmail.com>, "John Daley (johndale)"
 <johndale@cisco.com>, Sujith Sankar <ssujith@cisco.com>, David Marchand
 <david.marchand@redhat.com>, Neil Horman <nhorman@tuxdriver.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/enic: fix possible null dereference in notify set
Thread-Topic: [PATCH] net/enic: fix possible null dereference in notify set
Thread-Index: AQHdDgLic1VJg33sUkWUcDfgE8vi7bZk9BRw
Date: Thu, 9 Jul 2026 09:51:49 +0000
Message-ID: <IA3PR11MB89874A8F2890D7A13FDC87C3BFFE2@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20260707112014.82821-1-bigalex934@gmail.com>
In-Reply-To: <20260707112014.82821-1-bigalex934@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8987:EE_|DS3PR11MB9671:EE_
x-ms-office365-filtering-correlation-id: fb25a62a-4efa-4457-b0bc-08dedd9fb238
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|38070700021|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: tFDV0ByRoxFOorgb9qrUyKQbWD7m7p5noD+wKy+9HuqGmlwQaRiytl6aHtYyzJX/10Wegiq3abk9j0yj7ju3KIo3ceoUUnezJZVE9hZqr7KJtqGpM20q9TY6BWd5IUqw3UI8i8i08aqcJV9PpNdBQsnU+Y00vm43c6FGY9Sis9qVdLdQ1JDzCo5HtVNW1BdazSBkrNpUaBLr3E/RoTd9k5gV4b3ahpWXRN57q56Z1bsvkwmdmDdr8rPErJv6tnaDbHEt38NJrHR9vbS3B19lW71xnDAbQARdRWSHhUA3H5PlJjxr3SY6/7nHTbavTRGyYpLAdevMDr1oeIrS6k4IE1HfXXJQmEcHJyYY5A5hnUPpGNqRTvBE1Hv6g68Wk5L6j/M8ckVmjpzjI1uCUgct03Dv9VWhhiE/9ziTU8EBca7AKxk7QJQSbAiR0nVNTwsKczQrlAfhnmzSgJCOvLPR3bBpYFZ0+oUpdy9sWhqf73zsJ7MdVMjgJxi3dtfjMRAV4ksMM430Xo1aJ0dNzBm0ci5REvCeYlyO9yTlWp7XLrtdII9EVznvm9SP/Tqp/esmsDadAFGxUoNyYZBlzD5d184oGYcIv977YWiZP5Vql2yTXVYZZ0fafW7hU/fhi3IYysspnovOOH8xZRno6vr343/0HK3iMLm4IeuTCQi3hY8eqO9+YDdZedCIhbpjbLYkTcU0luIlwntYZ7799K4DLXkLIJaqxhqPk87hRCukDtI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(38070700021)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O6Ph/Md7iWnE6sy1MYK6W2ewWODpFlXlRN5LOLOQNcfdxiDrDYIShz3AXn6r?=
 =?us-ascii?Q?yhv2DHzNsD/LhtwgITdJOXiDGLwMkRr4n+Noj2+JC+xcGafGH87sFrvnDcW8?=
 =?us-ascii?Q?mOnIAkVQmqKA6aQIzMru8rFuqtWD/lYmlL+j0Ge68jIbYyCN0D7rpTJQ5hBv?=
 =?us-ascii?Q?QiFZcElrYJl5RNmX7n9KwT/l0lmf5iMn/xKSC7061gVa6nTRD7yXguSry07x?=
 =?us-ascii?Q?pjjcLk3HhNQ8r6sJv92s5xw7CGaNzF+lYmhKBhhiqj8FC9UfCXo84BrO8Iac?=
 =?us-ascii?Q?R2FRJonSFiBRygFdITtcLlbv4Pn9mmHpjd9RneOzxoXBwbUtP0EXKRyAzCVJ?=
 =?us-ascii?Q?mLSF++amTWmKaz8//pfYfdqxM2fYsBROiJEtqGbl0OaFP6ALX4Yg6HX7yOXH?=
 =?us-ascii?Q?RC1BBEMiXnGm01zw5+p+07r98MhKtldCKbMqfkINkD2BiOFDPZ4ArS0LFPIT?=
 =?us-ascii?Q?ZVlqH9uJ8NPmFkCYR83QBPx58QPg0Azxvb/PzdSYWLgIJortXdjwcYjCIASF?=
 =?us-ascii?Q?m/0PoO2ALLZCro4YTghlez00Sg1n9GeCXR2rQq8P8L+gKtajQfUMGxufC9yH?=
 =?us-ascii?Q?Dqz5TMfzPCBa5baNEM+iYjNXvLfKtZbpTwj7xLZYlEQNpF9IIGQ6X/jT5jkr?=
 =?us-ascii?Q?4HU+o/xVhvip/AcNL5+SYYZzLZCrnbpxULQHDWXRByZxqkoDly0cFRx0Hqeb?=
 =?us-ascii?Q?COjBFgbf94TAJadBuCnkGMlnuG2Jonmh4G7DdbMHbKd9hY4UcU9lfF0Ar6d8?=
 =?us-ascii?Q?DbF5OGFg4uqzgyzTrnvEj3po/m3UYnzSBgik6ic1LjhAzDZaWdeAxivc23ph?=
 =?us-ascii?Q?M54HRpN8QYXN4PQK1KhUmYSbUu4z5uHWHXpsYLJA3Ql8kII7wR5g/lJft98H?=
 =?us-ascii?Q?C8vfIy26CWdB2jwMcC2Zam86qeGgjmNliUFs8YVdndpgnuRurJY23QFAONGV?=
 =?us-ascii?Q?1qeBCKPlgClZTojrxAM5AjGOSX9RAlpmuvTsPXTavZitrt4oZtfo9nOGbZ/c?=
 =?us-ascii?Q?pMkEoRSC554yn3LwUbUGP7aPIbAjqFz0dDgGqMNu3Vpmp+6vYykzzX/hOmya?=
 =?us-ascii?Q?aMJBgvBnQz2wi1vmNHzo7IvNuWkV25b+mGFpp27ZrYh4qsUoVvSbpky/1jnX?=
 =?us-ascii?Q?Rf/wH9insRYiN9cr57ivpMvL3IbFaEgNxtXoiLqSjETMXFddnyJueumr4ZDI?=
 =?us-ascii?Q?BnRBSgoKasMOy7wpEClFRqZ4QRzf66kj3pj7m8l4QArJEiE16Ym1BCukw07C?=
 =?us-ascii?Q?BhdWE6h77RcuKEQn5odpuJxIsW4ov5ND08H+Rr/dQc9djBYOBRAKKhhbbu58?=
 =?us-ascii?Q?JkX0LE7yD+HM+VPuttmQ3cY/iTyB94A25Jhnfzy47gYs/+349HuaFrSyo1hj?=
 =?us-ascii?Q?0tySDHwYJ2gT4G2BKhpPs4hS2Ox14lBIpe6J6eHhk+sBZGn8SSOef7xGxKYf?=
 =?us-ascii?Q?dGspBFyELRlrLfl1ArdekxTVFebb7O4245rBaNtBa8PLiyL11SbTciAEkj4r?=
 =?us-ascii?Q?+/I7kTzh+8+LIlFDWA4uDP9kaGr2yjUDkAXMHluOauM7sEdUR5VHu+EH2C5s?=
 =?us-ascii?Q?lr5s95tf1/pJkcz2U8SscjbNzpUgEcFiduacFiNJjXClgl4QjK+bEe2M+4Vo?=
 =?us-ascii?Q?YpVScfR9toxdT2qsYkdp8LxSCg/veBqb+Dn/FjaGTdppK6IA0ygwiPBHCVNX?=
 =?us-ascii?Q?B7aXyWwGCkuo4yc/QUaUNQyyBqix8wv7ISpketjxKSZc5AHc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eJM2bH2cRoi1/6ZimWq6Togo28zf7FdAFXmzDjWUgNcvDCkP+7+m3cUnhP+n5qORWh1iZ1/wfvxbtrHSWE/Z6MuJtAyCHfajCl8bxlmeQOILnUKMNhIpgj1oXFtzH8D3gL8KRXL5AFsezzXMEppQ5f3eshHEZkOHQUv/AnvOzGN6406TDYktQPx3fQZIbEvY4ETLEupDyj1lNMUEz/bTq+JCZ8UD2T8A8DTGeZViWW7pKMinM0zDdKeJRfBl+7/wOj5xx+/lfb16cWRxDmnVrFURK+SFCitcMPOhoz6AybXSwYHmTC8LEuWYMJ7z7wJ323CtA64hQqb3J9Kh2gbhmg==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb25a62a-4efa-4457-b0bc-08dedd9fb238
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 09:51:49.2464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IE0IHTv13E2NMvIGZqlo7GNtNWWA8BprokE7GCk5On+n1wBkk63zXg2OlNqjhwB+W7cTqgwihu39cmy5kvQJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9671
X-Outbound-Client-TLS: ANONYMOUS; alln-opgw-1.cisco.com [173.37.147.229];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-l-core-04.cisco.com
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
> From: Alexey Simakov <bigalex934@gmail.com>
> Sent: Tuesday, July 7, 2026 8:20 PM
> To: John Daley (johndale) <johndale@cisco.com>; Hyong Youb Kim (hyonkim)
> <hyonkim@cisco.com>; Sujith Sankar <ssujith@cisco.com>; David Marchand
> <david.marchand@redhat.com>; Neil Horman <nhorman@tuxdriver.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Alexey Simakov <bigalex934@gmail.com>
> Subject: [PATCH] net/enic: fix possible null dereference in notify set
>=20
> The memset of notify_addr in vnic_dev_notify_setcmd() was performed
> unconditionally before the device reset check. When the device is in
> reset, vnic_dev_notify_set() skips the notification buffer allocation,
> leaving notify_addr as NULL. The subsequent call to
> vnic_dev_notify_setcmd() would then dereference the NULL pointer via
> memset.
>=20
> Move the memset inside the existing !vnic_dev_in_reset() guard where
> notify_addr is guaranteed to be valid.
>=20
> Fixes: 9913fbb91df0 ("enic/base: common code")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> ---
>  drivers/net/enic/base/vnic_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/enic/base/vnic_dev.c b/drivers/net/enic/base/vni=
c_dev.c
> index ba8ecc16f2..e6d34622af 100644
> --- a/drivers/net/enic/base/vnic_dev.c
> +++ b/drivers/net/enic/base/vnic_dev.c
> @@ -964,8 +964,8 @@ int vnic_dev_notify_setcmd(struct vnic_dev *vdev,
>  	int wait =3D 1000;
>  	int r;
>=20
> -	memset(notify_addr, 0, sizeof(struct vnic_devcmd_notify));
>  	if (!vnic_dev_in_reset(vdev)) {
> +		memset(notify_addr, 0, sizeof(struct vnic_devcmd_notify));
>  		vdev->notify =3D notify_addr;
>  		vdev->notify_pa =3D notify_pa;

notify_addr =3D=3D NULL (or bogus notify_pa) is a hard program error in
this function. Debug assertion might be more appropriate to make the
intention clear.

During init, the driver allocates the notify buffer while in_reset =3D=3D 0=
.
enic_dev_init() does not check the return code from vnic_dev_notify_set().
I think that needs to be fixed.

Thanks.
-Hyong

>  	}
> --
> 2.34.1

