Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19312C36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 18:09:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ABED4065A;
	Fri, 28 Mar 2025 19:09:30 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by mails.dpdk.org (Postfix) with ESMTP id E927F4021E;
 Fri, 28 Mar 2025 19:09:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZvnGFlmC8kILMJ76vVJsGP8wzNT2hcCIxUR9lkShp44phMmxuJ8SG7KFin/8VA1/rtVqjJ3boMfPsD9yBIlXX4tP2R80LJuwqgXJKYYbLmTeICKq3+gL+BjHAHl2NKviKCcH0LoRDQJ0Fx3VbUAtSVwU8dGMdt/JdXlZb5uoNRJDIF275lh/bP5NyaqZeMSurnJsuxQKpsl6faGMuwpNAbL8HhuqIF9CPKH0u2S4sqnFYY3/bV/EJxyqT2fLJB6TC1jWaaUZbbGxyJkopx8SF2yF/6kOEY4zODHDnftVSEwx/s4ec7OUqWmV3TUr1eBEJe5cEoWI3FGN1cIWEtavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpOjbUDkNFGcm4jaj1cZO9UQqtushVsh4D2E79nTdXs=;
 b=b5Bf/q76n6o7rvFPfSjjw/2rNl/1BDn8CbRFL12+Zp+MA3Q4xadt1AMaFzsV9IvQslRsZn4lKC6q6/lay4tgcaFRNRLF9Snj0/TCydVvjWulQ4m9Jm4wT8FUmT5ZrWjQ+uqkQl/I/p07AsMn8PZzUN+iELp65rIlLLm9J9lYZfSsgWyB7/kDdoVRqjbV2d4kvGlHugagvB20sOMa2EFuMYha8vIIn6PI093KLMYwOkn+wXM79HopAMuZM7ZgkGbbArTEzYaBq2erKu9ub28HcmlCYtR5Chv2ZbE6X7oxAHd3nTOjqkBJAUmk/Q3SY17h+6Gu5WGLhr4158SOp+G+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpOjbUDkNFGcm4jaj1cZO9UQqtushVsh4D2E79nTdXs=;
 b=s3rJwVpXzZmQEzQJYKWayKc91nr03XSP+uATC+arqlWjSX7JsRm9sNKjupI6agahyWZrOv56c6K9jk5rOuMOQLbGOHS+ttjgrJLv1iLGWTsZr3b6ZCkpmGTofRSBms71TsDHNvlOedGJCBruuudFleFFgumg30j1xE+XORhkKZ0UcgCtHHQwHsCJuUMe9E8n9ysta0II3AnDX9ayDAa8iqQfM1nSeoysz1Xd9g1gDsbVvqr6qocSSS5nqkmSJE5/UxCJ2e+jT70knxZMXNeu08WXBXEeEZlkweaCe96w9CsoVCWlatvgu5BlbRU7RFDFG225ZseWqLrJxmpNBPfFsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 18:09:26 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 18:09:26 +0000
Date: Fri, 28 Mar 2025 21:09:21 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
cc: =?ISO-8859-15?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, dev@dpdk.org,
 techboard@dpdk.org, thomas@monjalon.net, mkashani@nvidia.com
Subject: Re: DPDK for rust
In-Reply-To: <Z-V6GohKhnK0ywu2@bricha3-mobl1.ger.corp.intel.com>
Message-ID: <2e308be8-8ef3-963-cbb2-5cf68a3d3b3d@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB79@smartserver.smartshare.dk>
 <461725d-3c36-9b7f-c02d-f630dc8bc725@nvidia.com>
 <Z-V6GohKhnK0ywu2@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fac904-4b75-48cb-3c09-08dd6e23acde
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XlZp0/CLV/Rl6f21rwAU4zLFDZ60VnIgwZfjRq/eaelyFoua8IU8yc5A90p0?=
 =?us-ascii?Q?mmAtG5tBf/9Z7zr5AjDqAsVvzG0NK+svfBBWuP43yJCQ7vCnGO2QE7wsYMxN?=
 =?us-ascii?Q?TaKoZ7ER415gO0AJwuIpaolWpkjyyZCGmhZhOliHBToaK4rrahJETSRH88Oe?=
 =?us-ascii?Q?84jbPm+DBcNdFVWL5h6j1uwwG5yWGFZW+Tc4P8rrkFkyVT9Dd/DE6EGZOE6z?=
 =?us-ascii?Q?FHJAOzDV+faYlWg5AfNyikish5R275jFoEsisNV5V3VA/jUBxmtC9f/wd1B3?=
 =?us-ascii?Q?x9xwQOHmtixoJIcxhIpXEVzZuD79c6H5o+l6AlZi8mTcDDAI7Z2s0MMTRBAE?=
 =?us-ascii?Q?O0COyfE/5u+2KGw2AETOso9KCgGFJg7mzazVpw06SyB5EwF07jhQ8rwL6NTO?=
 =?us-ascii?Q?+CSUalSvMnKMxAaPx2/GeE/Y/Ru5invsayF3RKqyu8fpnDbXov6iyLqfUfuU?=
 =?us-ascii?Q?rE8BTRg29bakma78egriZr62Hw8/fr6A+P3wWbxOz5GM4/F8P9cUU2tMZQkI?=
 =?us-ascii?Q?J9CB0Jaz+lSX6fVSXyscCpgzF+Ln1pACHOwF+kY4btGO8ay7porMj0KHDYXR?=
 =?us-ascii?Q?HBQCRDwXsjZghHunuwQc1umKLk/mEdoHdzlTIKfF4TlgY29SO1ZNX66OvYZg?=
 =?us-ascii?Q?uYFPzA+gNz3k/tLn0hJQ4CVRgUF2eAoB9/fenUtgJ+IPs1HzxLsMg0HxXuz8?=
 =?us-ascii?Q?QIBkKRYbJQHDM75MLcvooYiYQGdlkiNDfegC48RkoiCmihDondWVCpRYSIdI?=
 =?us-ascii?Q?T83AMpX9AtNKA3lkEe16Xt6v37iLOPvvEsA7AcFOw+W3DUN6AyqVAdmaCmPk?=
 =?us-ascii?Q?ICarVZPQ/7H/p4vW1iQxwYS4q6OqrfWZ++MOzFQF8a68KBsKIm/451ZelfPS?=
 =?us-ascii?Q?iIhyKrz35ikn35jBUKgsnQtpa0mBuS1VBl9ba58Md8H0ItsF+iZw124lFy+e?=
 =?us-ascii?Q?vc3QIvjKpg5JWAP9JM8E8M/Yas7N+kFVjwTVTLQ1VnKUFKh3iiY6Y7AZgjRw?=
 =?us-ascii?Q?XKEAL1sUBbH6J4KdtQEgd8qmAx765TKlEQ2An0ob1Xo92P1cpCSsNM5kwlHT?=
 =?us-ascii?Q?rgqyAmFD5+/p4/cEiaUYn96a0BKj7RSaT4VgYZg51wwDWWBBNyVwPQWsmty3?=
 =?us-ascii?Q?OW853jFbnForj6B/vS81NLpI8/KcoooEQPXbotEqY/gSOcE7qsqb4oE+3hfx?=
 =?us-ascii?Q?2Kc9Ti7gbuOxpqqeTPA5nF8AincYlQLUa4IBZ6vFzsj6+pLR5Vxw0HERy0fL?=
 =?us-ascii?Q?+3rUBWjknDyV/gQgbQZlADa3xT/Q4p0JM0CBv+C6O4pI4Y+Q8D4Z0ou9DTLx?=
 =?us-ascii?Q?Kep1ws3s6tMkMGVkkTrTzsdD9710PnGBRf0CxC2JV5h+njX9AOUE3OmTEoBx?=
 =?us-ascii?Q?GETSSj7hWap7BpHaXBxd6KeFCgyV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFApdLJYj6vfl+qwzTbQKEWO0qM3ZnDgbjD2ZLPkCcOKQcIGx2E3fkZ5YGJq?=
 =?us-ascii?Q?u09celr/iR/tREBqaSx6m8kmuPa5c9pLDGtGDvbCyUcRFtmcHQM9EMF/GUgk?=
 =?us-ascii?Q?ryxJCmSJ8tPlfj4F+ZE8Why8oG1OLSy/Ckd74RthTEhIDVRxQyY5XslRuYws?=
 =?us-ascii?Q?AMzvzj+g9ciM/tvv1N9t9eORipLaXcyUTHOoCrPg+c2sW5EpvmrSuUbRT73I?=
 =?us-ascii?Q?ltGyrIVq980qo93AvF1/uZRrWvTHg70UIIMtWK+b28OCCn2v6F32wiG9MI/Z?=
 =?us-ascii?Q?AyHtoPCr4VSicGjEaNZtD0quPxLwpQeng7a4fh6ldShdNuy0T+D2avr4A6ZM?=
 =?us-ascii?Q?MWvFGMVEvDB72vlXTChv72HZTyOate2Np3GJ/oxNm3dFk9wfbdgttbDE/2Do?=
 =?us-ascii?Q?rnJ+ohmU5CW4X+f/HJBcI0sTCT3I5ntZwUuhCFRVxVgnVnPZoepoajOF56Fw?=
 =?us-ascii?Q?lhqmOMhxF9FoN3GKVipbXj0jELLRGQGVt93rjNiKmwxtQkujLNmxDB7iI786?=
 =?us-ascii?Q?knV4drp6q5zl38gaaNoK/4DXsot2bF0oSwbKsq9Pdh3b7F72g/bK0ImEqBbG?=
 =?us-ascii?Q?uEccUMMnrxylHmPBsfQlK5q3gSfZPSOy8SAMqZQHOWFAzVx4lZ0SHI530PBQ?=
 =?us-ascii?Q?kb8A7FuFf1SZieswXZlIylNFC9wmSsxDBmd2GQaFuKZ5KfMavfpW7LWiBc4t?=
 =?us-ascii?Q?L2un23RHN9T+9MfgapwAj4rui09hksYh/nZCFhqZ20DdFj9OjQgg/JKWUa/h?=
 =?us-ascii?Q?ojSENAMIzV7aG56egyggqwXp75UrjJi29r6gI4D/Uo/zgJHKtk/xTp+TZ3yq?=
 =?us-ascii?Q?pExq2tRdvtLhs75+GPsbHZ6wq52wDZsHguKrDz4s9i+ShvtYj42aE6E3MMoq?=
 =?us-ascii?Q?17OAxk9ooiZ5yRKAGtBuXIlnSYRdW3MWVAhscP2Rfj+PpeYalXDKbrEM/vio?=
 =?us-ascii?Q?VUxT101W1K0hBN/tV/3KiwNKdxYmBitfwAc4c1H52hTWYZAqg7TbEGdjrvPu?=
 =?us-ascii?Q?NtI7LYM67C422yWuAcUvGVqyl8Id1FPsTUPqexQaMqZWaWL58ruPSduVlfht?=
 =?us-ascii?Q?1JPZ3xwHJ0uVpCgc7lwMH5M4O484pzNEjSbJa/f0qKjhWN04BmqRq7yQvPMR?=
 =?us-ascii?Q?gK1rDjlRuVhNNppWKT4XsimuSxsF96x9rX+73GCWAfzcVAcX4vnakPbOSg9u?=
 =?us-ascii?Q?9l4N+S0n+B5tB98UWCve2XmayDG0qpRqZt6ec30WqP3VS30TFYKgxfZ5NmuN?=
 =?us-ascii?Q?DCxvowzsBSZvDddx0JwfKmMoKBqw4a/Z33ZcaN8gLmy32gN4uKY3yb1RUMxP?=
 =?us-ascii?Q?focqAIP7W69kKP7NHtkkMPdZsWdjkndWvi6uqd4oHTf75BEVKWUUkugN2WiM?=
 =?us-ascii?Q?oHCxbEBlW0R8h7MT/XQrXOCxe7BO7OLYnVSmATIJlYlfPZJCQVnigweBdqgp?=
 =?us-ascii?Q?iuX1TTdbgfi69lzYtVL/H18t117QcpFh5Mu6dkPfM3vl1OmH17UULnNuhEdp?=
 =?us-ascii?Q?8S2ChJoh58Q70jRCInBbLE7hJt7H0Kskn1Cs4zn6VzkoPmjzpriUqmvHHS+S?=
 =?us-ascii?Q?2wEWXT6bLQT/zQovXcJOKQT/plG8Qfjz0aGoW3HG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fac904-4b75-48cb-3c09-08dd6e23acde
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 18:09:26.1753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPOgqvVxUmwn7mL7zo9/i3WSe9VnAPZ7uRyZy4WkcpMC5/pGhxJDbNKAgT4phrXQ2R5uwq4XQCph7huHbIv+ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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

>> Hello Morten,
>>
>> Thank you for raising these questions !
>>
>>>
>>> Do we want the DPDK project itself to support rust?
>>> Or should parts of this be a DPDK hosted project, like grout?
>>
>> Rust packages management is different.
>> Also DPDK Rust code will eventually provide a different API.
>> At this stage, DPDK hosted project looks like a good idea.
>>
>
> For ease of use, that would mean hosting a cargo registry, no?
>

That's correct - cargo registry is the native way.
Also we may consider splitting the code between several crates.
That approach can provide more flexible way to arrange files.
