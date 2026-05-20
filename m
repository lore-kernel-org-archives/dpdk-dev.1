Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29333CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 13:29:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D5914029D;
	Wed, 20 May 2026 15:29:40 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A09B740144
 for <dev@dpdk.org>; Wed, 20 May 2026 15:29:39 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 702C3206EC;
 Wed, 20 May 2026 15:29:39 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 2/2] ethdev: add telemetry endpoint for list names
Date: Wed, 20 May 2026 15:29:36 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65887@smartserver.smartshare.dk>
In-Reply-To: <20260520093804.29102-3-fengchengwen@huawei.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 2/2] ethdev: add telemetry endpoint for list names
Thread-Index: AdzoPGQOXE2VPSFTQNeP+gi5hKhnKQAEKp8g
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <20260520093804.29102-1-fengchengwen@huawei.com>
 <20260520093804.29102-3-fengchengwen@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Chengwen Feng" <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, <andrew.rybchenko@oktetlabs.ru>,
 <bruce.richardson@intel.com>
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

> From: Chengwen Feng [mailto:fengchengwen@huawei.com]
> Sent: Wednesday, 20 May 2026 11.38
>=20
> Add /ethdev/list_names telemetry endpoint which returns a dictionary
> keyed by port ID with device name as the value, so users can
> identify ports by name directly from the telemetry output.
>=20
> Original /ethdev/list output:
>   {"/ethdev/list": [0, 1]}
>=20
> New /ethdev/list_names output:
>   {"/ethdev/list_names": {"0": "0000:7d:00.0",
>   "1": "0000:7d:00.1"}}
>=20

<rant>

Unfortunately, the telemetry protocol in DPDK is not using a common =
design, but takes parameters specific to each path.
It should have used OData or something similar, to standardize listing, =
filtering, etc.
Then we could have queried this like:
/ethdev/info?$select=3Dport_id,name
And return something like:
[
	{
		"port_id": 0,
		"name": "0000:7d:00.0"
	},
	{
		"port_id": 1,
		"name": "0000:7d:00.1"
	}
]
or:
[
	{
		0,
		"0000:7d:00.0"
	},
	{
		1,
		"0000:7d:00.1"
	}
]

But now we are stuck with what we have.

</rant>

So /etdev/list_names is OK.

I'm not really familiar with the DPDK telemetry, so I wonder if indexed =
arrays are normally returned as an object, like in this patch?

I would have expected a list function (such as list_names) to return an =
array.
Either a simple list:
{
	"/ethdev/list_names":
	[
		"0000:7d:00.0",
		"0000:7d:00.1"
	]
}

Or a list of objects:
{
	"/ethdev/list_names":
	[
		{
			"port_id": 0,
			"name": "0000:7d:00.0"
		},
		{
			"port_id": 1,
			"name": "0000:7d:00.1"
		}
	]
}

