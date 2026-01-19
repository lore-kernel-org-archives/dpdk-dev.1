Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C742ACCF2E8
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 11:23:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12F344025D;
	Mon, 19 Jan 2026 12:23:13 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012062.outbound.protection.outlook.com
 [40.93.195.62]) by mails.dpdk.org (Postfix) with ESMTP id D3F994025A
 for <dev@dpdk.org>; Mon, 19 Jan 2026 12:23:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaR2U5lg9TVaxIDQlawZwaaZJMQnhtjmCZAzDpSqSe00a7W02osbvqXUP0nLSJmUTOLh77mKA0gMy6WAe0jsbHj+mH3lnOEyqHKohmCyQllGjWDdLFDh2zA1z1ZNviD5Rzf6bmWMmkCOj2PxohqTS/NpLKId2sm9LJ0fWBqKsCGd4XDDY8n0/Rp6LbaNslivFoPKwP7yxjtOegr4+xOghaPgGnLhgme2Ncwz/lZOUTXowS86FilTXOAz3edeulGbIP2/Pw9Ws6UciyF9iV2ufYxN+kN7jGeQEly466YE1sYexVKw5GQqPR4SfxxBU4YVLHY/T+tILKpRREVhn78xYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkrHBwlOpUjNA9E+q0uuRO/g4ueM78YREcs/HG+nvL4=;
 b=wkZ2o9HIMfn2pERuTbp37xkwIBEoosWMkxiGgj02Jca6tSRZE93zQK+rnhfEUss7aer6N5rYj8NlrDfz5qPqYhnpkWT/ZZJ0iMpcDlSmGuew/kncAwA6CwbpR7j4Ww5m6JnBBTEgnVjNKfgji6YZNWqrh96qa9YbLUB2UVV9kN6jgAGJVEMcLTcUMvDYFTQtPmz8HaJSmvc0WHDOf0+3nOoFQhDaVaODOFYLgq8lLXV4AcZE23TBJqefARri0IiApGkf8eatcgN0cuv49xdjAAjsp6JrTNjk9khNfjRRzqmPKiVh49gx7YJcj9PVTG+binmnQrRaARrPxXBgDjIJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkrHBwlOpUjNA9E+q0uuRO/g4ueM78YREcs/HG+nvL4=;
 b=c2GGDlW65tz2SDDHMiFwO6191p0efLx8OrXhV+6pqJzwikahgpBYlFv2eCCCdG7X+FhQYd2vV7wwy7DrBfz6VSeUu09PwxVIJ7CVvp6gUUDCgGiep697IvUEKkXOkfiDMU/HkB2MxLvhVf8zA9M/1UyMiIuy5VPLRigmpCa7+6lpQU8IOPERTHy+YqumfD/2m2vgq7voSrIKhnWobu1cQtGsD9WGdo5Bq7GM0NldI0SOAZjBXMgS0XT7HI0Ho+6uUuzhloJ88X4gi+a+1ScaCIp17I2+SwR7fGm8t9rUF+rCowWTnEW26NlUqBKkSxMMETHUTGky8EGg6UZGUDe8Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY1PR12MB9581.namprd12.prod.outlook.com (2603:10b6:930:fe::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 11:23:07 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 11:23:07 +0000
Date: Mon, 19 Jan 2026 13:23:02 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: fengchengwen <fengchengwen@huawei.com>
cc: Gregory Etelson <getelson@nvidia.com>, andrew.rybchenko@oktetlabs.ru, 
 dev@dpdk.org, mkashani@nvidia.com, thomas@monjalon.net, 
 viacheslavo@nvidia.com, matan@nvidia.com, stephen@networkplumber.org
Subject: Re: [RFC PATCH v3] ethdev: support selective Rx data
In-Reply-To: <12514141-a489-4995-a8a7-e6d0fc28f841@huawei.com>
Message-ID: <03a55b2d-2957-c8ab-3c3e-dc9d207fc273@nvidia.com>
References: <20260104131301.196350-1-getelson@nvidia.com>
 <20260106154554.40556-1-getelson@nvidia.com>
 <12514141-a489-4995-a8a7-e6d0fc28f841@huawei.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY1PR12MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: f492067c-2661-4cfe-01cf-08de574d1ee5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?40vyP6SxFo7AX+6/879000yKybf3CdmSojxXwvrAGxbgl8+BHhPYiNYqy7sW?=
 =?us-ascii?Q?7nE41JxCVdZBa7Mhpu0CRO44hVf5xFmQd45+iQvghHuH3hBt7wSKi54B/OuT?=
 =?us-ascii?Q?pWRmAqHIj6AlKV2y4DrE9F3Yc5BMOqlahVbJRGJ8W4O+asucDy7VKXJ6rTm4?=
 =?us-ascii?Q?W2X+DSSl+bNelhwAi3zvfzPobKp5JCGA+3SYcoT0f95h0Rv5kcvjjMHN2RV7?=
 =?us-ascii?Q?qT3ZI+6bHV0iphU7FsfTgTSES4ScHIdnp3nGen9Ood1YMPcupEdAtHsLkkdJ?=
 =?us-ascii?Q?vOCtC+hB3XYhlZIJVlSOlV3tGzAaYAdH05CqPsbEe7dVQJt7R1+H0IQdsZiE?=
 =?us-ascii?Q?BEFOnTIfq5lQ2S6hOMXlQGBnxwvHhXWvj82z94oa9Ob4L0S5vehPU4N2uTlN?=
 =?us-ascii?Q?ehh7vrXg/5lNyqJlil/8jgNgsr8Xo6O4rbDWTXtfSSnx2Sx22pzupoFnosm1?=
 =?us-ascii?Q?q+S2xE1eU2GnIifPOLwvgPYf6SqnT4MNrpmPs/UhIkmhiFpSt2fdRUuBso0D?=
 =?us-ascii?Q?yHS+cXGgxYyEMpA0J8t0hQqGqwRM7z1k3+vzmAyDklNFV9vNwGh3AF6rgbYb?=
 =?us-ascii?Q?2EPRUIuLNwhD5WCzDy2VEs2PqJR1H8J0JZ87BGddoNPr8rSiHN4xb079QHSY?=
 =?us-ascii?Q?bYjkxfhp8Sd2i4KMJY7TgiVqTIWF+hJqhpG+ZRTZOCuimF9nAa/QRTVpiOQd?=
 =?us-ascii?Q?C8tBpRFXKcjgrA55X2YWdfU4L6UHKUxkNbSHroXfoidnx27iOHHsdBAbu9Ik?=
 =?us-ascii?Q?cX3nCLvyZ7cYzTrm5B4JI1CZOPFChZA9chSaMjuyHRrfraWYrz0qvtPAcXzA?=
 =?us-ascii?Q?g9UpA+HC8txXOuqZ2YynqF9lwjBSkrQV7RDQWBukrgETsAdb9YjK3+qC/KBn?=
 =?us-ascii?Q?nZhSt4iGU8tpxFuKHDvHdVtLmukfS9YP+/HQzODlroJQvwj9TEg1hWJXoMZb?=
 =?us-ascii?Q?+R96BLmhLlKiPQKxlWbl0kzbuzyWHbbdDNzs6giQc8LmCdfMeuCLXXlYMWsZ?=
 =?us-ascii?Q?iynIvdwpanLm92fnLsU5nGBIgkWfQIfl9N8sIbp0YbUDm2cOse4/KxjN+O5r?=
 =?us-ascii?Q?lgtpqjIP5514hGieaQikWzfzY01VQk3l4rFVNuOxFq4qmaPWqx2X8rbZiQ4N?=
 =?us-ascii?Q?CvbyF4eHsa0FZRAypBTMTUDJWsCcliCPBk4HTRkVJ0nwGsgCBF738cZEPRoS?=
 =?us-ascii?Q?qpxUVeuvM559ctArDd7+tNsPIX3Cxbpc2inKxSA5IMR2QyZ4rZUSj+vsMJnf?=
 =?us-ascii?Q?oppE6qwL6ECgTKM7rERczc/pA/65hFz9Tm0nVKmOjE/8svH0xu63iyJjrZdI?=
 =?us-ascii?Q?bNzS6pgkUwqtLPT/0N9KoHIEa4bQ0IoZKh3GhuvcazvV4T+TipJYSTNFsgcX?=
 =?us-ascii?Q?gxIjaQOyhST8KDRA+PhPtmbXpEoq17iQdtgs5Q4Qhf3hhBMUU4EIMfDj14ia?=
 =?us-ascii?Q?txnbjf1kKnDftYis2lTB232FX/HOgVT+YJsMlsIIP8iofEFfH0HwSdRrXYzP?=
 =?us-ascii?Q?qgGqKpj5CkL7bvHiDZjc4ZtQL4DexNojYBEQchcuTtOf7/9Yhttdx89ODjsJ?=
 =?us-ascii?Q?i2UvdMApseIvSgGzSi0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BikLwaPGE22fr29y4bsPNTvhAfboo0q7ZPnRMj1Ww1wTqHYKVaJajV1IjR+Y?=
 =?us-ascii?Q?830cqFzCOXZbY0/suRsLZ6TQgo2jKEXXnaFmBIIBCOwerRTOJJKzhShhW4TV?=
 =?us-ascii?Q?6qlAERwvGDF+3RwZkz9AwH0p6SimmHlfu54KYNb94ggj+pInw+k71PfRPh0U?=
 =?us-ascii?Q?exL3V5EFTXgI8SVCteDYMq38zPjQ7T+FPmA/5fJSeWI3a+QQ7zqPmH1HKlsb?=
 =?us-ascii?Q?PhdvcJ2RbENFOzYSXoo4V56TYWEPvHWKzkWu/v2kYEPdpsaaqvRM//IvdcB3?=
 =?us-ascii?Q?83hLXgFtgbf8WWtkNLbHiOntIrz7leF7nUSJHVawlj9N9/iG0UuIILK2snOB?=
 =?us-ascii?Q?0MRinoDpSUTE1p6eV9EJzlT2rPuLOiYEZiy2JPWLzCCSHFbOwcM24t1EsOZj?=
 =?us-ascii?Q?P85DmRqBrZdPxXjX5bq/dYhMyAnmOzh4LDX5i7Alb6ODhiGHmajGSbDtDRzB?=
 =?us-ascii?Q?vniQ3fKvf0921rmwM+o0GheXecpTjzux3tzg3j7xu5QuwshTegJ7I+Ij2f+a?=
 =?us-ascii?Q?8WBmurxWUAD1LIg6cYcdiDv2p7IG4K3eIyYF3K/yznQDvF7b2ljt+gYZ6VKg?=
 =?us-ascii?Q?DLWVPmVF6Bk7rLbI4fXP+Z1x3Xjh9sYdf9u9SammhtMS928WPmTUKQiMBPqd?=
 =?us-ascii?Q?WKSQ7mr1jzR8mlDmOFkhbjOtHtOPfSaC3qxWSPNid7T2h7am3X6DbnDGidwH?=
 =?us-ascii?Q?shvyCipXRBCK5c04DbkbtdbEZF1k7rmRpf8BREJI+XWWK723TEZqYVzD1PQ6?=
 =?us-ascii?Q?muSCcVU8U6bSfPWSBaunqwzhY7KB2BqLiBXq48F9qUJbIpoKX0ih/gSbR0+y?=
 =?us-ascii?Q?g4wlLoqnCcJ6n/PxvdmKms87X0OHfr1nJW6DusVKvswKp88+Y8RFAU4kdnaX?=
 =?us-ascii?Q?7DcBh1045a7+vS5McGxQZrt21uSCF+1fjcunF6Mp8LkvMd+rKpqOj8Y5Y/n0?=
 =?us-ascii?Q?ZTSjyLjdoF7QmhuV8n9WGJFqK1DG16fdSDQN5D0Nc2uVv6p7nDrX2mD1r9Zt?=
 =?us-ascii?Q?DTDkYc7qdC1GykEz/8A3g/Y9gSkB7Tn0JZXKjaOWt204OnvgpITMYfhcJywZ?=
 =?us-ascii?Q?LTNqH7/3XOvVwBewxsSLmvToESDdUT3w5jti1VmQNBm43QVeEPub0Duh761F?=
 =?us-ascii?Q?N7RsrFWXABoDE/yk8yDuos4oJt8lQb3rz6LjPl1y561XhBM4MV1ZZQz3N7At?=
 =?us-ascii?Q?k21CFLKtzwhMwso4GE2xZJjzJeO/Wlz4cMoRKWpLe+9HYdPGsba3Gbtg1QFO?=
 =?us-ascii?Q?gOkUp8ccFOx029/hT1R3Qd5vyd3V1BqiHT7GiXbLKXY+a0xXPdBnfu76bvF6?=
 =?us-ascii?Q?fIXqh+d4yY4yj49h9f149l24P7Z7Xmgfiiap47ihOdc3rNMNVlIGm5qea1rv?=
 =?us-ascii?Q?82gPLA9sbaljsrCUPNLG1NAgTZ0hTXTrJo52+NPZEz01EXnsojYedNzTBhqe?=
 =?us-ascii?Q?NRdvuqT26Ndqvhk2o4YHqBnpDHpR6e9umZBCVRh3rZQp5UqPTGLQlY4fbver?=
 =?us-ascii?Q?Ry0ojfyDa3XQ1r3rdMExIB3DJXE3xkuC+l/vD1NLqNE+pOQ8DHDs3fNml10a?=
 =?us-ascii?Q?kZRjZxR2gzgmlNiex5xXSBmepIr486a1Kgp2gldaTAhIV45w57VLHacncCDj?=
 =?us-ascii?Q?QwHIgKVVT/dwX8qiVV0QKo2ui62XlZv+PYwfIgQtdDFRgqcmlt1O7aOweM27?=
 =?us-ascii?Q?qq0UNCdXDNSev+jcmb4ERN/mtbt5FEPK7zRaKaqS0dmDBaWP0pV00d9iC2cq?=
 =?us-ascii?Q?4kHGysAsi1PkYh9CQHrMuHKHv3fbwYd5M94q645kn9WPHxbaQgvh9pvECgi0?=
X-MS-Exchange-AntiSpam-MessageData-1: kaK1IpMAz8EVog==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f492067c-2661-4cfe-01cf-08de574d1ee5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 11:23:07.8065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gz+70lPheKiUj0LCNCas3dt4Rb1HJkqBh39T5E/eg8MwHunCdSH20gVq+s/V3aKvsN9MMgUHuhlrSfgJTwT1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9581
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

Hello,

>> In some cases application does not need to receive entire packet
>> from port hardware.
>
> Which scenarios need to be used?

A typical use case for the selective Rx data read can be the SAMPLE flow action.
In that scenario, Rx queue that receives sampled packet copy can be configured 
to deliver to application partial packet data.

> What is the behavior when
> LRO(TCP packet aggregation is performed by hardware) is enabled?
>

The selective Rx data read is applied to MBUF layout that will be delivered to 
an application.
That functionality comes after all HW Rx offloads.

Regards,
Gregory
