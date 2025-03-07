Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95EAC19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 16:57:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D28E540E49;
	Fri,  7 Mar 2025 17:56:59 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by mails.dpdk.org (Postfix) with ESMTP id 1F43240E4A
 for <dev@dpdk.org>; Fri,  7 Mar 2025 17:56:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAa7DJ2wObjkqkwVsaA54LdaqNvXPxGNvJmaBV/S1ivajSQb8TZc5PBYTdAQlkHH3W1E24gt/FG5Hyf9Q2g67kWdAKH3LVNF0zd+88T5yYCWsWv63OLBQI5T54sbzyKDrBHmTGEqoxJAHHXvdSQNdSno+JdLEiHjQsQlfrCTNh+9m8ih7R5DhU0oElAR6XBzFnQz8DnPZ22v9XZ6pnR00jReYnkjdmj4dcQuMQvR3//5gIo1OPVjcXZZHfoM4cRa2jZHGjM7SiVfzaKO58bkCBJRnbf5oMO2zrKCjTUPoQXjM97RlUEok2bl2GxA4W7qLaDf+liuxMhHZxGIa9j9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B/HNs955G9y4P2J2rBU8B1A2BRNqvKl+ZXHt+W9bh4=;
 b=e6YJjCrugy9Xqc/ZMOmcT6huNAA4kpfcnt+0AOi5hb5IakLbwBRuZ7VO0LzdsvnokV4JWN+hp9oqSLe4sgLDNWqlrx1P7aCyXdGEKcVK5hjjCClzFdI/P8Ao8TJlDe9uACrFRECw+Vh//XVj2JextuHVE4EgXwPpu2ZCys6wz1y5gXhiPxYKLnmeVTgnaNNcnrEEpRUhmxiU8tVhBNivBBiLdLD6fqRmEDYAjSBWx/Z1W3k8zhEmU2+y0xWJwgspsnNUMn++xj/uqt+So9FlkwhvLDg4aBc834esoEZj9nVcYReKLvmmomkbGUdWyAh0nAtZo+f/6lxCTEI8sEeywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B/HNs955G9y4P2J2rBU8B1A2BRNqvKl+ZXHt+W9bh4=;
 b=SXkEtdv8pfIMJg9BWoCDRDk4P32fJmpWOIs/jBvj42XtirrDUDpMWCkJJrNRDeX4lU4bLWOTDI4+6xFQmCUtJooPvcvpJtpcSBkt15Wtkbnc7VX45viUzmqGk2nKH42OdD4z2+MzGh2POYRS7kkJ2jJPCJi+N86B1IbRPYK00UNhx0WsQDN/eaS1479QhZXD51QBBLiR3zsDJEnuYzoNpenn1Yj79Ey1jGaogAocTWwN8BhcPz4ixj2r4V/jc38sMuDOsTlD2SKpCTlLGFm9qU+Cf70k8xrjU5x4cDJomLNZi6lJlbO6gXnvhQ4nZyQliND1icbQT+lN3D4Sro1mMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9)
 by BN7PPFED9549B84.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Fri, 7 Mar
 2025 16:56:55 +0000
Received: from PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8]) by PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 16:56:54 +0000
Date: Fri, 7 Mar 2025 18:56:46 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
cc: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "mkashani@nvidia.com" <mkashani@nvidia.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
In-Reply-To: <PH8PR11MB68034D4DDB371E3197C7F82ED7CA2@PH8PR11MB6803.namprd11.prod.outlook.com>
Message-ID: <7231c395-9534-981b-adf9-c43cae444284@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <PH8PR11MB68034D4DDB371E3197C7F82ED7CA2@PH8PR11MB6803.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To PH7PR12MB6811.namprd12.prod.outlook.com
 (2603:10b6:510:1b5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6811:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab53cd8-7c45-42a4-4c72-08dd5d991098
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sIG0YijadJ1ht2F7LNCGgEE7XtBkqfNVF5i2TqX/Z6m2JFTJT1D1ATK9JmR2?=
 =?us-ascii?Q?sVY4hp6uXQn0h20Zark1GbdZP/rdTUj8ykkLwtoRLPKlxM6tLz+Nu63LR2SE?=
 =?us-ascii?Q?KeZjMcnUP3+VR9qMcUJCpo+9PIeLPokjvVasfYJ5UO6GCS1/415pKDqTaSGg?=
 =?us-ascii?Q?sn//bdYN63zjy66mivlq3BwOYptsjVv8m6HBeNHYMHUcShZ6cjldlUxYUm4Z?=
 =?us-ascii?Q?yL5ADffN+6EnrRJZaFGkVzUcwTiUEyDaU/wnFKZEFPbJcwhiHV3Hxs4xtvlN?=
 =?us-ascii?Q?tRuJbmUuMNmzslyXIr9RQfzqWtjty+oIS7deW7ExE6S8dQh1ebPACU9WMVqp?=
 =?us-ascii?Q?bPgSk3M0Zr4OC0TEGap+RLrOQg+XqwKYApn/5vgiM6Ura2UgQqqwLH0H0GKs?=
 =?us-ascii?Q?FKW5DWVheQ5XW9VeN/lnDB3lEfnupTV52X5sftaBL+e1+wzpmy5JvqJGoBYJ?=
 =?us-ascii?Q?0bmWsxcOUHZ1XtxgoNWzbzkd36kG6XvjOpQQ4sOKtbsfpSzKrL77WTEl5WMP?=
 =?us-ascii?Q?93i3E117FHdjnGVUwk3+5ssMrGjI+rn+pSIQh/CzhQV/Bxd1x7BBMB7z3eHx?=
 =?us-ascii?Q?p7M7jrNWriWmH4KKYSpkh7PDz+F2p1ytyfFmTTsBE2g8z8j3vFZxiOzoBjHA?=
 =?us-ascii?Q?1Nwlh6xtXlUyWVCZ4CsyPZpzdbGPXGD0U84kOKK4h6c0vGkxoUyGGNQ1TKOt?=
 =?us-ascii?Q?bi1DW97nvL8pWUCck4Its6sUEufef74hT+K8lG/en7K6qniMGFxsVYN3Mr6J?=
 =?us-ascii?Q?mU/tPBlYRqGz65kx3BbisbKogap5YhnMtXAC0hQPqEIWHnFNIcuLrzdUcabz?=
 =?us-ascii?Q?uxnWcTWih/Bn2C8ol5v385tniztv/q1UCDoYRMufe14U5KOtgAPOdaPnZd9s?=
 =?us-ascii?Q?HX8Skgp0qWQoiUxbrAPDlr+JZ7c0BmLXrT6mwfj+u/DeFzrd0mN2w6hSpkRT?=
 =?us-ascii?Q?5niJJtc8yq9GwmNdNW9M7mf83WSSXnIqsjfmnWIRulNqRiESiJFSS5prgrt4?=
 =?us-ascii?Q?cpK/pycl0Uls55Ti2jZym9Gp1hL1sOXp78Zexivxmyb1Hs54FNBfu07GePMp?=
 =?us-ascii?Q?Li3KHh4BjwyS7qhNlR9vvKJXkzgVUlaxf3ksAxq+TuC431Fp3qT6luOMnEvz?=
 =?us-ascii?Q?xq76A3zJ2Y7XV8rLmdEpv4huejT+MyY3UucgiZnRMRKLW2lbu3p2F6N+oZzB?=
 =?us-ascii?Q?y6kBfKPPBTX7WsjTWZ/w6CCjKHmIApiB8Iwmu9GS7ItnJ3FgZAxZiOIUjZXz?=
 =?us-ascii?Q?AlGudPa4Nk9ThKkVdVxqGynzIqK7Zp5mcY4cInLCkP8aVf8RJqdoyVxCG+l1?=
 =?us-ascii?Q?I9t77c8ZAgdZTVVyPfJgWu7F86Xy/I7vS7vjJTCRy3j/QEsgaJDoekCZPKiO?=
 =?us-ascii?Q?PtZU+2VXhDwWS29ULluNySJ7e3Nf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6811.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KpskewSvhHKCCGZpy9xJowVycSwaDBXwWotl2DUTGwLu/llp6JnlyV1xh+w1?=
 =?us-ascii?Q?ncd+Q6tSyMDa86kW3Dz51qG0XIK1iaGQAmZXA5mk76ApaHplB/TTLfxixPq1?=
 =?us-ascii?Q?euH2YJrb7hKUvPh9K2Le8+k69rHlwxGLDKOBq0q79slaFRrQ/pZ7N/+aPtFS?=
 =?us-ascii?Q?YDY69CCn3MZjdIQvDLBUyP1VzvOQgh9hqXU87WQVjJtXxs07GU7l86ey+cBE?=
 =?us-ascii?Q?Unuw7dFqS3/WrSgnohQaIiytAcr2QtZ18DFi5UMJG7uqRBdZ4K6X/KuwqQIi?=
 =?us-ascii?Q?w2eN5rMamtnyBxQ99Cj3VLVla9MWXqVOEAShoUeOgPen3uA57Xz1pAXnlKxe?=
 =?us-ascii?Q?XAaIdluB+8lJ1E1HnhXYfJVKWX2KUjg0mUp12shqRTRotkJs24xdkiczX14h?=
 =?us-ascii?Q?+taE55+FAJoN5bqkaPhiNqep2PnYpq6wBpxxiVB09/X2rNtRTch75uJKjHuX?=
 =?us-ascii?Q?90DYlBavtAdQPO11WzeMR1Bv5l+7ZeUf3Zz5ipsgLCYRwbTBOD/3g6AtFTZ1?=
 =?us-ascii?Q?Hev7zpBVQEbNnXaFws64UXn5oczemwAZRnKD6iHsiIKhelmu0oFe39borswH?=
 =?us-ascii?Q?y5coRTKI+lioJ3SaG6CGFbfLa/e+bAEZBZquOskBwVShj+nzhoEQNqGDWIqX?=
 =?us-ascii?Q?/09cwciE7iUHmtNen1Ov8zA3KgN8FGf3MOflajS5vBArU1m3djosf013siK0?=
 =?us-ascii?Q?ECz222DOtPUthwCbakb8I5w7Z2dVP2QzzmaBiZ+g+HP96n3fbvG1A0TbvZn5?=
 =?us-ascii?Q?hWaXYPuatmCKpL0l/DKFxwbxZO8wRz0IyFPIxEJEh8rG5su0W9LY1yybSSLS?=
 =?us-ascii?Q?iB3Gok/8ceC4U9vXcqw3mVLdem/Uf2Az1YXx+Rwe9eEpuz9gHgCiJoHWmeM0?=
 =?us-ascii?Q?bH6csRff9dqhl66qSuqjMPvv0p9JafHrD/wH7NUcdkELfPVo2t7VwFxGyrv9?=
 =?us-ascii?Q?Uw2bXukthLXn6WprEBD1kUr6SgaXqLdcWxzwLVONIPuXzVeMRkxNXmnUZTLW?=
 =?us-ascii?Q?GkwumYpmnPpSF+bzTNWZ8S1rjCsPpba6BbTLFUFYOycfL5/7kVhiInY6BBDn?=
 =?us-ascii?Q?oGv3YGfiaCzFpfi9c4eq0yJ08TaahsmZK0w5tLo2PzXwBlMpJaVK80FSkL8F?=
 =?us-ascii?Q?ucpXnzIgIRaGIJ74pucV9M+F0JB8frTv2uzLicc9E/IOQuS4x14D50TxtA/3?=
 =?us-ascii?Q?I9R7oKx/oOMgfNfiBJ0TkKMpIc7YDCJGOjM9AsRsbcmHuGOYA4HFqIWzWA20?=
 =?us-ascii?Q?oiyunVdX8A6sj3Spc1KaZzdUIqojdVm26wTLkx2/7uT2G5n9ekWgN5EYC20S?=
 =?us-ascii?Q?t1NspQk/gL+P3Otfb5V8u99klwZsgZHbn2vGrOQdty4Qsz25r3sjOppqrMDH?=
 =?us-ascii?Q?/z2TiWE5/mg5tgJj6WJmeWZKlvj40ip1hcS0VyK8jsL9e7/Xxt6X3hgX2Ze1?=
 =?us-ascii?Q?S3n2dzqzaS01pqKhG5g9f0GsIvarptYAVEW58ejHwXCAPfk00JnTInl5Rd1S?=
 =?us-ascii?Q?uEEOzVd0RLUJC9F+9sfD/rgrOCzEmm5TkpcwNqYFQyFJwSB0yIG4tSXTcgS+?=
 =?us-ascii?Q?SL1371nMlcEgfEcIV0XbU5rXtZqEroVRTkttqyzQUd7sTpz0xtFMuktBoR6K?=
 =?us-ascii?Q?FYEv5M0IRyjuzEap4w6a9qzpxD5oJs4YyX5wu2uqPoYy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab53cd8-7c45-42a4-4c72-08dd5d991098
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6811.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:56:54.8351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iz8yLnOrasirWIjrVBV/kN5LJzyqfmr1/dYE0tE+/DNtlXxRONhzb5axXQwzJFuGgoEE4nfMTfantCRK7qErew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
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

Hello Harry,

>
>> From: Gregory Etelson <getelson@nvidia.com>
>> Sent: Thursday, March 6, 2025 1:37 PM
>> To: dev@dpdk.org <dev@dpdk.org>
>> Cc: getelson@nvidia.com <getelson@nvidia.com>; thomas@monjalon.net <thomas@monjalon.net>; mkashani@nvidia.com <mkashani@nvidia.com>; Richardson, Bruce <bruce.richardson@intel.com>
>> Subject: [PATCH] rust: support DPDK API
>
> Cool, I like this subject, great!
>
>> The patch converts include files with DPDK API to RUST and binds new
>> RUST API files info dpdklib package.
>>
>> The RUST dpdklib files and DPDK libraries build from C sources
>> allow creation of DPDK application in RUST.
>>
>> RUST DPDK application must specify the `dpdklib` package as
>> dependency in Cargo.toml file.
>>
>> RUST `dpdklib` package is installed into
>> MESON_INSTALL_DESTDIR_PREFIX/rust directory.
>>
>> Software requirements:
>> - clang
>> - RUST installation
>> - bindgen-cli crate
>>
>> RUST dpdklib installation instructions:
>> 1. Configure DPDK with `-Deanble_rust=true`
>> 2. Build and install DPDK. The installation procedure will create
>>    MESON_INSTALL_DESTDIR_PREFIX/rust directory.
>> 3. Update PKG_CONFIG_PATH to point to DPDK installation.
>
> Interesting approach to automate it; are there specific reasons that this approach was taken,
> or did this just seem the easiest/best way to include "Rust support" into upstream DPDK?
> Alternatives could be (*not* suggesting to rework the patch!) a dpdk-sys
> crate where the bindgen etc is done externally to DPDK itself. Many existing
> approaches (some examples: https://youtu.be/lb6xn2xQ-NQ?t=130) use that method.
>
> I kind of like (this approach) of having the binding generation upstream with DPDK itself;
> it makes the Rust support upstream and keeps it close to DPDK... however it
> means that it is "the one" official/DPDK-community-approved library/crate.
>

My reason for adding the crate directly into upstream DPDK branch was to produce 
a single centralized RUST version of DPDK API.
If DPDK API files are converted externally, there is no control over the result.
Internal crate can help smoothing bindgen translation - DPDK files can be 
adjusted to reduce manual translation corrections.
The crate content will be automatically updated after DPDK API change.
Also, internal crate will increate overall RUST awareness in DPDK comunity.

> There's some nice tidy-ups to cleanup the namespaces possible if this is "the crate".
> Perhaps (sorry, borderline bikeshed-topics..) renames for clarity & readability, e.g.:
> dpdklib::rte_eal::rte_eal_init()

The crate exports existing DPDK API to RUST application as it is.
This way RUST application receives stable DPDK API - the same one C applications 
have.

>   to
> dpdk::eal::init()
>

That is not current DPDK API.

>> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
>
> I'll get to a testing & review in the next days, however I'd like to ask some bigger picture
> questions, to understand/provide input on approach, and how big an effor to expect here!
> See above linked youtube video - I had sketched out some API concepts for exposing a
> "safe Rust API" wrapper around the DPDK C API, which also encodes threading requirements.
>
> Some questions:
> - Is there an overaching "we're trying to achieve X with Rust", or specifically "safe Rust"?
> - Is this patch the "get DPDK + Rust working", with follow up patches for "safe wrappers" the intention?
> - Or is this patch all to expect for now?

The goal was to create RUST application over existing DPDK API.
The patch converts DPDK API files required for the helloworld example.
Additional API files will be added on demand.

>
> Again, thanks for the patch, I think Rust is important for DPDK & infrastructure software,
> and will try make time to help test/review/discuss this patch, and the wider Rust effort!
>
> Regards, -Harry
>
> <snip code itself>
>

Regards,
Gregory
