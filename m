Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC48C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 22:53:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A31C4028F;
	Thu,  5 Jun 2025 00:53:07 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012013.outbound.protection.outlook.com [52.101.71.13])
 by mails.dpdk.org (Postfix) with ESMTP id C27914028E
 for <dev@dpdk.org>; Thu,  5 Jun 2025 00:53:05 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vDZG9ttoz7+4WYd310z1rWd3INlzQWBcgL1fdUEPeaWDCBjG1aPiZ38tCzlCtEeAyxCdYkqPeaENKOtxH/iB+SOC4wXf0M982jjPKsL7YZaVgBO0hcJeXDM0zB/xUSQmKcQld59lO1KZIO/PWw8vdlqXQx1XU13/0PnKytTwzV2L72KAaRmKGzn/AoE+PKq6LbP07jUQYuUqbMSZxZEJHOTdCbQCJSAWO7rjIQ1A+5FkDkZqTMdk2ehRH0wpZBV6oJ/6qtbymDh8H8aV2O7E7xAV9Zxh0GcyiesXxAQgYyyp2H4sa66TqhvCGsJ+KrL8eYmUOXuvzLWGa5qffVqEag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiYSBMR5IecYDyAOoEmN3A9bVdiA/nIJHIchIQY3t7M=;
 b=PwcjEasp96gDmKmdFqzRAVEn4Z8r2Fb5M7hUMmrMCjziR3qGvLSCJH1AJA3UCYv5BJ/JVbHNdK+cdNt3PGmsIqn/7w6PX4ujSDWOGwDYa0jNxX0mp4xabpCOLtba55IV38g8DGl7BmC0GmEC3CqAx2LiOJg5V2TzFy1o/W8GFHj6+VmKJmSJtw4TeBVlIL3XO0QkLwUfTTqBK5KIHgEc/ymgLZygGKjrTBpYfQpp5jCqS6C6t/F1yTx7Zu2S1yI7Z8qSp61tw5fdKjwI5tEe1lvL0Nii2yDdsH1ypIHSY7QwnbxvVVMaIpvNTCYLYbhOaATJjEMaIf4YHigZ8IDIfw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiYSBMR5IecYDyAOoEmN3A9bVdiA/nIJHIchIQY3t7M=;
 b=f+vghqdEGrmZgHY4oUV57ZbOADa7Rk04/+1RveepV8zoNIs5kdajs9kNWEDDV/24geoqzKLdGpPhsbto+pof4Lb8+WZ7kXdGaLtgpxLf8XxG1O0VUW7WOeGG/VrgIvIbqXZvle9L8PNw7yo4nYOr6xwpX1VEaiU9ctpHYgWD6RQ=
Received: from DUZPR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::14) by AS8PR08MB8993.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 4 Jun
 2025 22:52:59 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::fa) by DUZPR01CA0027.outlook.office365.com
 (2603:10a6:10:46b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 4 Jun 2025 22:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Wed, 4 Jun 2025 22:52:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0/4WPDZNP6l+nEKG/IMepDDbwr/er+gvV6cRL/TJWFAJ4mSwdeEdWE+KxT9qWUPgBx/PssH2YvJ0b+Lq6BMhEUF0H8IXgKjVXSA+8ckrw3nEakyXwSWLurQ7MfUbnYVr5tavvzIx9CV3tGnEf4nyU6EV69sJSOCe3JkXubFtBOkZm6Ges9eUuvEViH+FRNIoZ19COqCSapb4XTWAbr5b/GSO26bchqYeF5t2U3LakmaBvnaKnVhyfQWP8KyCWULUWrN5AmSWFw2hjkY8XwnvgAY0EjrzuvJfNVXzXT8FxROyJfMcBfINs1J0j8Zxa5jxW0P20M1oglHLSMu5WQjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiYSBMR5IecYDyAOoEmN3A9bVdiA/nIJHIchIQY3t7M=;
 b=TAcvRe5Fq/w+aW6aNiGXBY2Pmhim0K1i5oYC7LRbSwmOMCRdkPzJuG2bq2Bd3Njno6NC6mxxqGqCikekMTw2axaxTiyl919XN633B3iWmF9yzmJQtGBLGcdevl3jI3K7TafzWZ/hc4L1RgJCieEs3tyo0u6JGoen43JLF4f2MeBOW4gHbF0INy/RWsVnIvXyB6x1zJ13SxXxDPoSt+Wj1li6SmxLfeqwMldv+ULNIbf3t/3YdwSaZxlEzVeX3EWXgqHTflX0hkyySLhn5fiKjWb2bowY+hOZii/XGS1PP2NL3/KfnNJyW/eaD6iaE7ng7ESeBsmWwsDyKdz0gpAd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiYSBMR5IecYDyAOoEmN3A9bVdiA/nIJHIchIQY3t7M=;
 b=f+vghqdEGrmZgHY4oUV57ZbOADa7Rk04/+1RveepV8zoNIs5kdajs9kNWEDDV/24geoqzKLdGpPhsbto+pof4Lb8+WZ7kXdGaLtgpxLf8XxG1O0VUW7WOeGG/VrgIvIbqXZvle9L8PNw7yo4nYOr6xwpX1VEaiU9ctpHYgWD6RQ=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AM0PR08MB5475.eurprd08.prod.outlook.com (2603:10a6:208:188::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 22:52:24 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%7]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 22:52:24 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Gaetan Rivet <grive@u256.net>,
 "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>, nd
 <nd@arm.com>
Subject: RE: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hints
 API
Thread-Topic: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hints
 API
Thread-Index: AQHb1A8LVwjtBj2HM0KwVaHXGcaVP7PzOp8AgABXn0A=
Date: Wed, 4 Jun 2025 22:52:24 +0000
Message-ID: <PAWPR08MB89092A3A53CBFA874B1AEA729F6CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-3-wathsala.vithanage@arm.com>
 <aEB6VEFCKr-2t11p@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEB6VEFCKr-2t11p@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|AM0PR08MB5475:EE_|DB1PEPF000509F3:EE_|AS8PR08MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: e747d74d-2bdf-4150-eece-08dda3ba8cda
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?fHQ4NbCpKGvv68RXy0TtEuco/vSAkA8mBh0TL6SS/iQ04osyuHkGXDim6EdM?=
 =?us-ascii?Q?x12Lm8yA0QCKKli5imMp/NifXJt3qtfBxBRDwLZtMy/JDedouWRaeAlv4pMh?=
 =?us-ascii?Q?RCImiuGuAuI2XxX6CyyxWyIJGypXQchyXSbMTPZzRlyhvJqMqnXJDc5ryRb+?=
 =?us-ascii?Q?3hZE2VsNGNecAqxJia7gUPtE/WRZHafUxy4JB7hQ7y6VEoFEKl9O+UGTb1It?=
 =?us-ascii?Q?WClQiSFad55UeQqmYD4Sqb9A66BDuUU1ZhM7cKRYcF1QC16X1P9EgKzo4ZKo?=
 =?us-ascii?Q?vkeMpmHOYNX5f21Gi9whoePY/5XZzJjJx8BbJrXBjVNHEXGFtI9OGenxg33Z?=
 =?us-ascii?Q?kjTXpl8k1kfu2hh3tmSSJSGS3HmJyxg6bzacTt83N7+0EuPDLlSZXy03Agkm?=
 =?us-ascii?Q?LP6/UuClwjKTFWFL0OXqbJtZtPMK34DoT6u4hC92t3B9CohDSv0m9V5vX5et?=
 =?us-ascii?Q?yCZY9sPR4jIAZqesdF5wvwtEQ+S5RTXFL7sPXlMP/ckA7+E1xZRwmyX6VeMa?=
 =?us-ascii?Q?EI21HduI59IOL6xK4AJlx7AFbmagYeMyuQNw/F3N/IzUjOFwUDjlrK0zlukP?=
 =?us-ascii?Q?t7bw/TB8D0aADLFV7vEVzZPSrXuyDHyWC0TIDBHgo65UvR3NuwpNVHCL2c0b?=
 =?us-ascii?Q?SoLZtWjCSjLDEN3Uaia+gLsAypHoZAcFZzygIgCM9Y8SkC9VlSnd6lI+vYzz?=
 =?us-ascii?Q?NCWYZU63IVXTw7l8dRBFIdUjbPzaCqxDeVmMh249A4I7JGHvlT9VS+S0RZLc?=
 =?us-ascii?Q?QslqthZcHdXQ+vnpIRqZyaCeCk2NIcbkt0m0jorDKO39qVDAMaskC9dVn2JL?=
 =?us-ascii?Q?nSQ0V4kzbZxuh0J4HCaMLFuYfLjCmoMLFHdqlUJvjpthoBDFYKJML3NrW5Ky?=
 =?us-ascii?Q?+X0WM5zYOt7UKsmiA0Rc0ll9Hxn1bnoZsJIgNnOl5HpoI/IboiaTnkFVZoof?=
 =?us-ascii?Q?XA0kwQX0Fs75KBDvFbSQiCFc8guQuivOpvaYugjB+2yF3D0vLDhcx8RLRJGS?=
 =?us-ascii?Q?S0BhjoKA0OjMPdwPhuSTfQXSs/BVhgy27sc96BJ6aeasaN5Uas9xm7xRsMYK?=
 =?us-ascii?Q?XIUJAVSjvJCZA3My75YzD7GYYS/C9Kjjc83dy/imoyVU/TBZamKOa9JWYaOj?=
 =?us-ascii?Q?6wj4xF6aJks2ZR00pK+dZXM6C0e8TjC1tHT0IFjYY/LIcX7I8CyjP5sKbIbX?=
 =?us-ascii?Q?5DCptP2Cth/50A0zW1flvPpfoNsqLnxIo/ue6t5Y0DzhKCAJRODmGABPdBsp?=
 =?us-ascii?Q?smwzq+0zxLfpSSEqNbNJRqkHr2ENQ0YbrGRDl7nAeUtsjxqcQHGkj1PwQafY?=
 =?us-ascii?Q?xsITnAj2SkUbh/UkIMwHuL6lgDgdGuRL7dr+wpD/o1MBTN5h0JeffnWss52e?=
 =?us-ascii?Q?trwjlCUs9/l754tFNj8TUGMgbdl2wT2FXLg750xBwp5T+mtYR9Tte7JWsW6i?=
 =?us-ascii?Q?lyO9HGdKLLLiRj5C8RnlCTI2KcKH9qKCIUyGyktAfq9DfxWcpgm+w5UAd0AS?=
 =?us-ascii?Q?yEqsddIsQU1H7DM=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5475
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2672a662-e5e9-4ebd-6d5c-08dda3ba791a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|35042699022|82310400026|1800799024|376014|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HFTGUWpMe5TeXwQm5NwBM9WunNJKvTskszFSeJnbXGAVlgDp3yIKlmwQyH7Q?=
 =?us-ascii?Q?mXHlIpRcADA6Yvvve3sa7YyG2HZF/OHu9yCgoXoF/7TZVKrjUxdyd/GEtJmw?=
 =?us-ascii?Q?QlaQ3XGPqMk7mgCvBc2aDCPAsOGjQime8jOD2ke//3TUGV05f7gK1b3yk5kz?=
 =?us-ascii?Q?ZZfP2hnnUspYaSLbkmG6J/aDEvTIuv3MKxYcxAEuZURkm6L1uwZ0CNbTKl/t?=
 =?us-ascii?Q?DXSRgesDmChQebi52kWbpuyNIAjEkvLBkUXnLqZ/kabD3nPhYKcW/mFXw6yZ?=
 =?us-ascii?Q?4ny9byoSEtl+4ldUpRHaqwUtzGmLeZMmpBeavef3gfsp5Br6xVXv7ZsJ6QMV?=
 =?us-ascii?Q?tlc8TsJkjRV7l+cLy7Qp7T0R4RZdYc9t36lHwVQ39fN205Kg+IRiIaYiPIoX?=
 =?us-ascii?Q?7uH9WdCx9x+A8sM8fiCo3fDPN/kn573LqROs9fKAv/pySNaIf1N/ucK+WSLL?=
 =?us-ascii?Q?85ae1HCOGlVxV4GZKix2tBQFamfdag9wrtL6IRsB2M/AC6AgwxutmjIAR7I2?=
 =?us-ascii?Q?0SBMAXiffsGBLQt5rz2mf0bn03FuARM6mBhrjWTVZOZwg/iQfzd/0PMJFlHu?=
 =?us-ascii?Q?AnpW28uXFQTWm7BHOKFF1biR3CT3YwuXLBpXB45nrDUexilbKgFHrZDhxIu0?=
 =?us-ascii?Q?i0Z7HcklJcvFg/mm1YcxUjZR7qiZyMogDE+0+xQbdqXIEy5MMx3Y8xIVkI0/?=
 =?us-ascii?Q?L6qss0Dx6fPTLWxQSMMCwj0OjuQr2Brd7Dg3Hamewz+wFTyMDIim3WpZHR6s?=
 =?us-ascii?Q?4DOtSHb4t9oeLr3lImreFTiF9qb+Wc9zURC1SR+6rJytGpTznBfZJM5S2jH1?=
 =?us-ascii?Q?h0MJ28t776fKYGbf7PO2a5PJXAD2rrw2frXK7S22/xBMNeIymO3TbYzpK31l?=
 =?us-ascii?Q?tjew+HcyWz3uXBViLhJeV61lV9SZ11VdiS3PHfsUyKAe8ybsU8LT2lCS3WpP?=
 =?us-ascii?Q?n1x0+q0IKkP52iCOnsuYbHqV8B1PDcqYKLUfHFk5MKVTv34W70Vq3X7M0Bc9?=
 =?us-ascii?Q?z8gkHXvyg6cj63V42f7HdS5N/aUwpV1ngzbNwiVeRTcFYsSfx4RzlToiadIc?=
 =?us-ascii?Q?q0NFP4iIAvMx+eIiCcew4/2VxVGx0aTTxcLrCDlNI0OHPBZdEDee00vBifZI?=
 =?us-ascii?Q?RV9xH0J1V4/1+W9C2Vam1tIWqlkywYDS12oJ1zSWRPgBctD5clj0Rqj37O0e?=
 =?us-ascii?Q?lykZ099WQ6c2p324spOjumojGHoUxXyyRy1Bfaoblb/am2qoI4COxsfZkV/c?=
 =?us-ascii?Q?6UIHrZDC7HVNhBbzowuFRDXyklMvJN4YLEOWK8ybJQ+jNaGBxGboVmDMUAV6?=
 =?us-ascii?Q?Nar3kpQ/iROLYtZ4rQYIFHSoInb+qo8wY6hNnoHzSbNxnU6P2XLNG4KLJO0M?=
 =?us-ascii?Q?AkyNpDY9U3RSkQm/jxvVCzu6FGFQrRU/xuDvA+4Um0+MOwEeaKzeDJX9CMbY?=
 =?us-ascii?Q?0CZ00bbtT52eGiap0HmAqIyUt1LANmgAmS1xzelSWUO5fdOHuu7jKYXne7vo?=
 =?us-ascii?Q?6UjyUwdWTboB5iD0EeQ1bd40x7EFKur/flh/gZ6/2nvhEQFWgVDNe4vXpQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(35042699022)(82310400026)(1800799024)(376014)(14060799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 22:52:57.7535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e747d74d-2bdf-4150-eece-08dda3ba8cda
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8993
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

> > rte_pci_tph_st_{get, set} functions will return an error if processing
> > any of the rte_tph_info objects fails. The API does not indicate which
> > entry in the rte_tph_info array was executed successfully and which
> > caused an error. Therefore, in case of an error, the caller should
> > discard the output. If rte_pci_tph_set returns an error, it should be
> > treated as a partial error. Hence, the steering-tag update on the
> > device should be considered partial and inconsistent with the expected
> outcome.
> > This should be resolved by resetting the endpoint device before
> > further attempts to set steering tags.
>=20
> This seems very clunky for the user. Is there a fundamental reason why we=
 cannot
> report out what ones passed or failed?
>=20
> If it's a limitation of the kernel IOCTL, how about just making one ioctl=
 for each
> individual op requested, one at a time. That way we will know what failed=
 to
> report it?
>=20

The V1 of the kernel patch had that feature, but it was frowned upon, and I=
 was
asked to implement the IOCTL this way. Please find it here (V1)
https://lore.kernel.org/kvm/20250221224638.1836909-1-wathsala.vithanage@arm=
.com/T/#me73cf9b9c87da97d7d9461dfb97863b78ca1755b

> Other comments inline below.
>=20

I will address them in the next version.

Thanks.

--wathsala

> /Bruce
>=20
> >
> > Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> > Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
> > Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> > ---
> >  drivers/bus/pci/bsd/pci.c        |  43 ++++++++
> >  drivers/bus/pci/bus_pci_driver.h |  52 ++++++++++
> >  drivers/bus/pci/linux/pci.c      | 100 ++++++++++++++++++
> >  drivers/bus/pci/linux/pci_init.h |  13 +++
> > drivers/bus/pci/linux/pci_vfio.c | 170 +++++++++++++++++++++++++++++++
> >  drivers/bus/pci/private.h        |   8 ++
> >  drivers/bus/pci/rte_bus_pci.h    |  67 ++++++++++++
> >  drivers/bus/pci/windows/pci.c    |  43 ++++++++
> >  lib/pci/rte_pci.h                |  15 +++
> >  9 files changed, 511 insertions(+)
> >
> > diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
> > index 5e2e09d5a4..dff750c4d6 100644
> > --- a/drivers/bus/pci/bsd/pci.c
> > +++ b/drivers/bus/pci/bsd/pci.c
>=20
> <snip>
>=20
> > diff --git a/drivers/bus/pci/bus_pci_driver.h
> > b/drivers/bus/pci/bus_pci_driver.h
> > index 2cc1119072..b1c2829fc1 100644
> > --- a/drivers/bus/pci/bus_pci_driver.h
> > +++ b/drivers/bus/pci/bus_pci_driver.h
> > @@ -46,6 +46,7 @@ struct rte_pci_device {
> >  	char *bus_info;                     /**< PCI bus specific info */
> >  	struct rte_intr_handle *vfio_req_intr_handle;
> >  				/**< Handler of VFIO request interrupt */
> > +	uint8_t tph_enabled;                /**< TPH enabled on this device *=
/
>=20
> question: what would happen if we always enabled tph for each device. Doe=
s
> doing so disable the default handling for the device?
>=20
> >  };
> >
> >  /**
> > @@ -194,6 +195,57 @@ struct rte_pci_ioport {
> >  	uint64_t len; /* only filled for memory mapped ports */  };
> >
> > +/**
> > + * @warning
> > + * @b EXPERIMENTAL: this structure may change, or be removed, without
> > +prior
> > + * notice
> > + *
> > + * This structure is passed into the TPH Steering-Tag set or get
> > +function as an
> > + * argument by the caller. Return values are set in the same
> > +structure in st and
> > + * ph_ignore fields by the calee.
> > + *
> > + * Refer to PCI-SIG ECN "Revised _DSM for Cache Locality TPH
> > +Features" for
> > + * details.
> > + */
> > +struct rte_tph_info {
> > +	/* Input */
> > +	uint32_t cpu_id;	/*Logical CPU id*/
> > +	uint32_t cache_level;	/*Cache level relative to CPU. l1d=3D0,l2d=3D1,=
...*/
> > +	uint8_t flags;		/*Memory type, procesisng hint etc.*/
> > +	uint16_t index;		/*Index in vector table to store the ST*/
> > +
>=20
> These fields should be reordered in order of size to avoid unnecessary ga=
ps.
>=20
> For the flags field, I dislike having different sets of flags all multipl=
exed into a
> single field. Can we instead of the flags field, and the set of #defines =
below split
> these out into separate enums, and then have separate fields for each one=
.
>=20
> For example:
> 	struct rte_tph_info {
> 		uint32_t cpu_id;
> 		uint32_t cache_level;
> 		enum rte_tph_mem_type mem_type;
> 		enum rte_tph_hint hints;
> 		enum rte_tph_mode mode;
> 		...
> 	}
>=20
> While the structure takes more space this way, this is not a datapath str=
ucture
> that we should be seeing large arrays of it, or that needs to be processe=
d quickly,
> so usability should be prioritized over size/compactness.
>=20
>=20

+1

> > +	/* Output */
> > +	uint16_t st;		/*Steering tag returned by the platform*/
> > +	uint8_t ph_ignore;	/*Platform ignores PH for the returned ST*/
> > +};
> > +
> > +#define RTE_PCI_TPH_MEM_TYPE_MASK		0x1
> > +#define RTE_PCI_TPH_MEM_TYPE_SHIFT		0
> > +/** Request volatile memory ST */
> > +#define RTE_PCI_TPH_MEM_TYPE_VMEM		0
> > +/** Request persistent memory ST */
> > +#define RTE_PCI_TPH_MEM_TYPE_PMEM		1
> > +
> > +/** TLP Processing Hints - PCIe 6.0 specification section 2.2.7.1.1 */
> > +#define RTE_PCI_TPH_HINT_MASK		0x3
>=20
> Looking at the mask usage below, does this mask not need to also be shift=
ed by
> the TPH_HINT_SHIFT? Otherwise it overlaps with the type mask.
>=20
> > +#define RTE_PCI_TPH_HINT_SHIFT		1
> > +/** Host and device access data equally */
> > +#define RTE_PCI_TPH_HINT_BIDIR		0
> > +/** Device accesses data more frequently */
> > +#define RTE_PCI_TPH_HINT_REQSTR		(1 <<
> RTE_PCI_TPH_HINT_SHIFT)
> > +/** Host access data more frequently */
> > +#define RTE_PCI_TPH_HINT_TARGET		(2 <<
> RTE_PCI_TPH_HINT_SHIFT)
> > +/** Host access data more frequently with a high temporal locality */
> > +#define RTE_PCI_TPH_HINT_TARGET_PRIO	(3 <<
> RTE_PCI_TPH_HINT_SHIFT)
> > +
> > +#define RTE_PCI_TPH_ST_MODE_MASK   0x3
> > +/** TPH no ST mode */
> > +#define RTE_PCI_TPH_ST_NS_MODE	   0
> > +/** TPH interrupt vector mode */
> > +#define RTE_PCI_TPH_ST_IV_MODE	   1
> > +/** TPH device specific mode */
> > +#define RTE_PCI_TPH_ST_DS_MODE	   2
> > +
>=20
> As above, I think these would be nicer defined in different enums, going =
to
> separate fields in the struct. That would also remove any ambiguity as to=
 whether
> the masks include the shift or not.
>=20

+1

> >  #ifdef __cplusplus
> >  }
> >  #endif
> > diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
> > index c20d159218..b5a8ba0a86 100644
> > --- a/drivers/bus/pci/linux/pci.c
> > +++ b/drivers/bus/pci/linux/pci.c
> > @@ -814,3 +814,103 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
> >
> >  	return ret;
> >  }
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 25.07) int
> > +rte_pci_tph_enable(struct rte_pci_device *dev, int mode) {
> > +	int ret =3D 0;
> > +
>=20
> Should check here if dev->tph_enabled is already true.
>=20

+1

> > +	switch (dev->kdrv) {
> > +#ifdef VFIO_PRESENT
> > +	case RTE_PCI_KDRV_VFIO:
> > +		if (pci_vfio_is_enabled())
> > +			ret =3D pci_vfio_tph_enable(dev, mode);
> > +		break;
> > +#endif
> > +	case RTE_PCI_KDRV_IGB_UIO:
> > +	case RTE_PCI_KDRV_UIO_GENERIC:
> > +	default:
> > +		ret =3D -ENOTSUP;
> > +		break;
> > +	}
> > +
> > +	if (!ret)
>=20
> Prefer "ret =3D=3D 0" for this comparison.
>=20
> > +		dev->tph_enabled =3D 1;
> > +
> > +	return ret;
> > +}
> > +
>=20
> Function could probably be shortened to something like (including a check=
 for
> already enabled, 2 lines shorter if we rely on checks in the
> vfio_tph_enable() call):
>=20
> int
> rte_pci_tph_enable(...)
> {
> #ifdef VFIO_PRESENT
> 	if (dev->kdrv =3D=3D RTE_PCI_KDRV_VFIO && pci_vfio_is_enabled()) {
> 		if (dev->tph_enabled =3D=3D 0) {
> 			int ret =3D pci_vfio_tph_enable(...);
> 			if (ret !=3D 0)
> 				return ret;
> 			dev->tph_enabled =3D 1;
> 		}
> 		return 0;
> 	}
> #endif
> 	return -ENOTSUP
> }
>=20
>=20
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_disable, 25.07) int
> > +rte_pci_tph_disable(struct rte_pci_device *dev) {
> > +	int ret =3D 0;
> > +
> > +	switch (dev->kdrv) {
> > +#ifdef VFIO_PRESENT
> > +	case RTE_PCI_KDRV_VFIO:
> > +		if (pci_vfio_is_enabled())
> > +			ret =3D pci_vfio_tph_disable(dev);
> > +		break;
> > +#endif
> > +	case RTE_PCI_KDRV_IGB_UIO:
> > +	case RTE_PCI_KDRV_UIO_GENERIC:
> > +	default:
> > +		ret =3D -ENOTSUP;
> > +		break;
> > +	}
> > +
> > +	if (!ret)
> > +		dev->tph_enabled =3D 0;
> > +
> > +	return ret;
> > +}
>=20
> As above, we can shorten this function by replacing the switch with a str=
aight
> check for kdrv =3D=3D RTE_PCI_KDRV_VFIO. Same with functions below too.
>=20
=20
+1

> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_get, 25.07) int
> > +rte_pci_tph_st_get(const struct rte_pci_device *dev,
> > +		   struct rte_tph_info *info, size_t count) {
> > +	int ret =3D 0;
> > +
> > +	switch (dev->kdrv) {
> > +#ifdef VFIO_PRESENT
> > +	case RTE_PCI_KDRV_VFIO:
> > +		if (pci_vfio_is_enabled())
> > +			ret =3D pci_vfio_tph_st_get(dev, info, count);
> > +		break;
> > +#endif
> > +	case RTE_PCI_KDRV_IGB_UIO:
> > +	case RTE_PCI_KDRV_UIO_GENERIC:
> > +	default:
> > +		ret =3D -ENOTSUP;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_set, 25.07) int
> > +rte_pci_tph_st_set(const struct rte_pci_device *dev,
> > +		   struct rte_tph_info *info, size_t count) {
> > +	int ret =3D 0;
> > +
> > +	switch (dev->kdrv) {
> > +#ifdef VFIO_PRESENT
> > +	case RTE_PCI_KDRV_VFIO:
> > +		if (pci_vfio_is_enabled())
> > +			ret =3D pci_vfio_tph_st_set(dev, info, count);
> > +		break;
> > +#endif
> > +	case RTE_PCI_KDRV_IGB_UIO:
> > +	case RTE_PCI_KDRV_UIO_GENERIC:
> > +	default:
> > +		ret =3D -ENOTSUP;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > diff --git a/drivers/bus/pci/linux/pci_init.h
> > b/drivers/bus/pci/linux/pci_init.h
> > index 25b901f460..e71bfd2dce 100644
> > --- a/drivers/bus/pci/linux/pci_init.h
> > +++ b/drivers/bus/pci/linux/pci_init.h
> > @@ -5,6 +5,7 @@
> >  #ifndef EAL_PCI_INIT_H_
> >  #define EAL_PCI_INIT_H_
> >
> > +#include <rte_compat.h>
> >  #include <rte_vfio.h>
> >  #include <uapi/linux/vfio_tph.h>
> >
> > @@ -76,6 +77,18 @@ int pci_vfio_ioport_unmap(struct rte_pci_ioport
> > *p);  int pci_vfio_map_resource(struct rte_pci_device *dev);  int
> > pci_vfio_unmap_resource(struct rte_pci_device *dev);
> >
> > +/* TLP Processing Hints control functions */ __rte_experimental int
> > +pci_vfio_tph_enable(const struct rte_pci_device *dev, int mode);
> > +__rte_experimental int pci_vfio_tph_disable(const struct
> > +rte_pci_device *dev); __rte_experimental int
> > +pci_vfio_tph_st_get(const struct rte_pci_device *dev,
> > +			struct rte_tph_info *info, size_t ent_count);
> __rte_experimental
> > +int pci_vfio_tph_st_set(const struct rte_pci_device *dev,
> > +			struct rte_tph_info *info, size_t ent_count);
> > +
> >  int pci_vfio_is_enabled(void);
> >
> >  #endif
> > diff --git a/drivers/bus/pci/linux/pci_vfio.c
> > b/drivers/bus/pci/linux/pci_vfio.c
> > index 5317170231..bdbeb38658 100644
> > --- a/drivers/bus/pci/linux/pci_vfio.c
> > +++ b/drivers/bus/pci/linux/pci_vfio.c
> > @@ -12,6 +12,7 @@
> >  #include <stdbool.h>
> >
> >  #include <rte_log.h>
> > +#include <eal_export.h>
> >  #include <rte_pci.h>
> >  #include <rte_bus_pci.h>
> >  #include <rte_eal_paging.h>
> > @@ -1316,6 +1317,175 @@ pci_vfio_mmio_write(const struct rte_pci_device
> *dev, int bar,
> >  	return pwrite(fd, buf, len, offset + offs);  }
> >
> > +static int
> > +pci_vfio_tph_ioctl(const struct rte_pci_device *dev, struct
> > +vfio_pci_tph *pci_tph) {
> > +	const struct rte_intr_handle *intr_handle =3D dev->intr_handle;
> > +	int vfio_dev_fd =3D 0, ret =3D 0;
> > +
> > +	vfio_dev_fd =3D rte_intr_dev_fd_get(intr_handle);
> > +	if (vfio_dev_fd < 0) {
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	ret =3D ioctl(vfio_dev_fd, VFIO_DEVICE_PCI_TPH, pci_tph);
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int
> > +pci_vfio_tph_st_op(const struct rte_pci_device *dev,
> > +		    struct rte_tph_info *info, size_t count,
> > +		    enum rte_pci_st_op op)
> > +{
> > +	int ret =3D 0;
> > +	size_t argsz =3D 0, i;
> > +	struct vfio_pci_tph *pci_tph =3D NULL;
> > +	uint8_t mem_type =3D 0, hint =3D 0;
> > +
> > +	if (!count) {
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	argsz =3D sizeof(struct vfio_pci_tph) +
> > +		count * sizeof(struct vfio_pci_tph_entry);
> > +
> > +	pci_tph =3D rte_zmalloc(NULL, argsz, 0);
>=20
> For ioctl we should not need pinned memory. Use regular malloc here.
>=20

+1

> > +	if (!pci_tph) {
>=20
> Coding style guidelines say to compare pointers explicitly to NULL.
>=20

+1

> > +		ret =3D -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	pci_tph->argsz =3D argsz;
> > +	pci_tph->count =3D count;
> > +
> > +	switch (op) {
> > +	case RTE_PCI_TPH_ST_GET:
> > +		pci_tph->flags =3D VFIO_DEVICE_TPH_GET_ST;
> > +		break;
> > +	case RTE_PCI_TPH_ST_SET:
> > +		pci_tph->flags =3D VFIO_DEVICE_TPH_SET_ST;
> > +		break;
> > +	default:
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	for (i =3D 0; i < count; i++) {
> > +		pci_tph->ents[i].cpu_id =3D info[i].cpu_id;
> > +		pci_tph->ents[i].cache_level =3D info[i].cache_level;
> > +
> > +		mem_type =3D info[i].flags & RTE_PCI_TPH_MEM_TYPE_MASK;
> > +		switch (mem_type) {
> > +		case RTE_PCI_TPH_MEM_TYPE_VMEM:
> > +			pci_tph->ents[i].flags |=3D VFIO_TPH_MEM_TYPE_VMEM;
> > +			break;
> > +		case RTE_PCI_TPH_MEM_TYPE_PMEM:
> > +			pci_tph->ents[i].flags |=3D VFIO_TPH_MEM_TYPE_PMEM;
> > +			break;
> > +		default:
> > +			ret =3D -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		hint =3D info[i].flags & RTE_PCI_TPH_HINT_MASK;
>=20
> As pointed out above, unshifted, this HINT_MASK overlaps with the TYPE_MA=
SK.
>=20
> > +		switch (hint) {
> > +		case RTE_PCI_TPH_HINT_BIDIR:
> > +			pci_tph->ents[i].flags |=3D VFIO_TPH_HINT_BIDIR;
> > +			break;
> > +		case RTE_PCI_TPH_HINT_REQSTR:
> > +			pci_tph->ents[i].flags |=3D VFIO_TPH_HINT_REQSTR;
> > +			break;
> > +		case RTE_PCI_TPH_HINT_TARGET:
> > +			pci_tph->ents[i].flags |=3D VFIO_TPH_HINT_TARGET;
> > +			break;
> > +		case RTE_PCI_TPH_HINT_TARGET_PRIO:
> > +			pci_tph->ents[i].flags |=3D
> VFIO_TPH_HINT_TARGET_PRIO;
> > +			break;
> > +		default:
> > +			ret =3D -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		if (op =3D=3D RTE_PCI_TPH_ST_SET)
> > +			pci_tph->ents[i].index =3D info[i].index;
> > +	}
> > +
> > +	ret =3D pci_vfio_tph_ioctl(dev, pci_tph);
> > +	if (ret)
>=20
> Again, check explicitly for "=3D=3D 0".
>=20

+1

> > +		goto out;
> > +
> > +	/*
> > +	 * Kernel returns steering-tag and ph-ignore bits for
> > +	 * RTE_PCI_TPH_ST_SET too, therefore copy output for
> > +	 * both RTE_PCI_TPH_ST_SET and RTE_PCI_TPH_ST_GET
> > +	 * cases.
> > +	 */
> > +	for (i =3D 0; i < count; i++) {
> > +		info[i].st =3D pci_tph->ents[i].st;
> > +		info[i].ph_ignore =3D pci_tph->ents[i].ph_ignore;
> > +	}
> > +
> > +out:
> > +	if (pci_tph)
> > +		rte_free(pci_tph);
>=20
> Free functions work fine with null pointers, so just call free without a =
null check.
>=20

+1

> > +	return ret;
> > +}
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_enable, 25.07) int
> > +pci_vfio_tph_enable(const struct rte_pci_device *dev, int mode) {
> > +	int ret;
> > +
> > +	if (!(mode ^ (mode & VFIO_TPH_ST_MODE_MASK))) {
>=20
> So it's an error to twice set the mode to the same thing? should it not j=
ust be a
> no-op?
>=20

This doesn't make sense; I will fix this in next version.

> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	} else
> > +		mode &=3D VFIO_TPH_ST_MODE_MASK;
> > +
> > +	struct vfio_pci_tph pci_tph =3D {
> > +		.argsz =3D sizeof(struct vfio_pci_tph),
> > +		.flags =3D VFIO_DEVICE_TPH_ENABLE | mode,
> > +		.count =3D 0
> > +	};
> > +
> > +	ret =3D pci_vfio_tph_ioctl(dev, &pci_tph);
> > +out:
> > +	return ret;
> > +}
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_disable, 25.07) int
> > +pci_vfio_tph_disable(const struct rte_pci_device *dev) {
>=20
> Check here, or in caller to see if it's already enabled?
>=20

This check should happen in rte_pci_tph_disable() rather than here which is
specific for Linux. I will do the check where you pointed it out earlier.

> > +	struct vfio_pci_tph pci_tph =3D {
> > +		.argsz =3D sizeof(struct vfio_pci_tph),
> > +		.flags =3D VFIO_DEVICE_TPH_DISABLE,
> > +		.count =3D 0
> > +	};
> > +
> > +	return pci_vfio_tph_ioctl(dev, &pci_tph); }
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_st_get, 25.07) int
> > +pci_vfio_tph_st_get(const struct rte_pci_device *dev,
> > +		    struct rte_tph_info *info, size_t count) {
> > +	return pci_vfio_tph_st_op(dev, info, count, RTE_PCI_TPH_ST_GET); }
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(pci_vfio_tph_st_set, 25.07) int
> > +pci_vfio_tph_st_set(const struct rte_pci_device *dev,
> > +		    struct rte_tph_info *info, size_t count) {
> > +	return pci_vfio_tph_st_op(dev, info, count, RTE_PCI_TPH_ST_SET); }
> > +
> >  int
> >  pci_vfio_is_enabled(void)
> >  {
> > diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
> > index 38109844b9..d2ec370320 100644
> > --- a/drivers/bus/pci/private.h
> > +++ b/drivers/bus/pci/private.h
> > @@ -335,4 +335,12 @@ rte_pci_dev_iterate(const void *start,  int
> > rte_pci_devargs_parse(struct rte_devargs *da);
> >
> > +/*
> > + * TPH Steering-Tag operation types.
> > + */
> > +enum rte_pci_st_op {
> > +	RTE_PCI_TPH_ST_SET, /* Set TPH Steering - Tags */
> > +	RTE_PCI_TPH_ST_GET  /* Get TPH Steering - Tags */ };
> > +
> >  #endif /* _PCI_PRIVATE_H_ */
> > diff --git a/drivers/bus/pci/rte_bus_pci.h
> > b/drivers/bus/pci/rte_bus_pci.h index 19a7b15b99..e4d4780f54 100644
> > --- a/drivers/bus/pci/rte_bus_pci.h
> > +++ b/drivers/bus/pci/rte_bus_pci.h
> > @@ -31,6 +31,7 @@ extern "C" {
> >  struct rte_pci_device;
> >  struct rte_pci_driver;
> >  struct rte_pci_ioport;
> > +struct rte_tph_info;
> >
> >  struct rte_devargs;
> >
> > @@ -312,6 +313,72 @@ void rte_pci_ioport_read(struct rte_pci_ioport
> > *p,  void rte_pci_ioport_write(struct rte_pci_ioport *p,
> >  		const void *data, size_t len, off_t offset);
> >
> > +/**
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change without prior notice.
> > + *
> > + * Enable TLP Processing Hints (TPH) in the endpoint device.
> > + *
> > + * @param dev
> > + *   A pointer to a rte_pci_device structure describing the device
> > + *   to use.
> > + * @param mode
> > + *   TPH mode the device must operate in.
> > + */
> > +__rte_experimental
> > +int rte_pci_tph_enable(struct rte_pci_device *dev, int mode);
> > +
> > +/**
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change without prior notice.
> > + *
> > + * Disable TLP Processing Hints (TPH) in the endpoint device.
> > + *
> > + * @param dev
> > + *   A pointer to a rte_pci_device structure describing the device
> > + *   to use.
> > + */
> > +__rte_experimental
> > +int rte_pci_tph_disable(struct rte_pci_device *dev);
> > +
> > +/**
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change without prior notice.
> > + *
> > + * Get PCI Steering-Tags (STs) for a list of stashing targets.
> > + *
> > + * @param mode
> > + *   TPH mode the device must operate in.
> > + * @param info
> > + *   An array of rte_tph_info objects, each describing the target
> > + *   cpu-id, cache-level, etc. Steering-tags for each target is
> > + *   eturned via info array.
> > + * @param count
> > + *   The number of elements in the info array.
> > + */
> > +__rte_experimental
> > +int rte_pci_tph_st_get(const struct rte_pci_device *dev,
> > +		struct rte_tph_info *info, size_t count);
> > +
> > +/**
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change without prior notice.
> > + *
> > + * Set PCI Steering-Tags (STs) for a list of stashing targets.
> > + *
> > + * @param mode
> > + *   TPH mode the device must operate in.
> > + * @param info
> > + *   An array of rte_tph_info objects, each describing the target
> > + *   cpu-id, cache-level, etc. Steering-tags for each target is
> > + *   eturned via info array.
> > + * @param count
> > + *   The number of elements in the info array.
> > + */
> > +__rte_experimental
> > +int rte_pci_tph_st_set(const struct rte_pci_device *dev,
> > +		struct rte_tph_info *info, size_t count);
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > diff --git a/drivers/bus/pci/windows/pci.c
> > b/drivers/bus/pci/windows/pci.c index e7e449306e..218e667a5a 100644
> > --- a/drivers/bus/pci/windows/pci.c
> > +++ b/drivers/bus/pci/windows/pci.c
> > @@ -511,3 +511,46 @@ rte_pci_scan(void)
> >
> >  	return ret;
> >  }
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 25.07) int
> > +rte_pci_tph_enable(struct rte_pci_device *dev, int mode) {
> > +	RTE_SET_USED(dev);
> > +	RTE_SET_USED(mode);
> > +	/* This feature is not yet implemented for windows */
> > +	return -1;
> > +}
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_disable, 25.07) int
> > +rte_pci_tph_disable(struct rte_pci_device *dev) {
> > +	RTE_SET_USED(dev);
> > +	/* This feature is not yet implemented for windows */
> > +	return -1;
> > +}
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_get, 25.07) int
> > +rte_pci_tph_st_get(const struct rte_pci_device *dev,
> > +		   struct rte_tph_info *info, size_t count) {
> > +	RTE_SET_USED(dev);
> > +	RTE_SET_USED(info);
> > +	RTE_SET_USED(count);
> > +	/* This feature is not yet implemented for windows */
> > +	return -1;
> > +}
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_set, 25.07) int
> > +rte_pci_tph_st_set(const struct rte_pci_device *dev,
> > +		   struct rte_tph_info *info, size_t count) {
> > +	RTE_SET_USED(dev);
> > +	RTE_SET_USED(info);
> > +	RTE_SET_USED(count);
> > +	/* This feature is not yet implemented for windows */
> > +	return -1;
> > +}
> > diff --git a/lib/pci/rte_pci.h b/lib/pci/rte_pci.h index
> > 9a50a12142..da9cd666bf 100644
> > --- a/lib/pci/rte_pci.h
> > +++ b/lib/pci/rte_pci.h
> > @@ -137,6 +137,21 @@ extern "C" {
> >  /* Process Address Space ID (RTE_PCI_EXT_CAP_ID_PASID) */
> >  #define RTE_PCI_PASID_CTRL		0x06    /* PASID control register */
> >
> > +/* TPH Requester */
> > +#define RTE_PCI_TPH_CAP            4       /* capability register */
> > +#define RTE_PCI_TPH_CAP_ST_NS      0x00000001 /* No ST Mode Supported
> */
> > +#define RTE_PCI_TPH_CAP_ST_IV      0x00000002 /* Interrupt Vector Mode
> Supported */
> > +#define RTE_PCI_TPH_CAP_ST_DS      0x00000004 /* Device Specific Mode
> Supported */
> > +#define RTE_PCI_TPH_CAP_EXT_TPH    0x00000100 /* Ext TPH Requester
> Supported */
> > +#define RTE_PCI_TPH_CAP_LOC_MASK   0x00000600 /* ST Table Location */
> > +#define RTE_PCI_TPH_LOC_NONE       0x00000000 /* Not present */
> > +#define RTE_PCI_TPH_LOC_CAP        0x00000200 /* In capability */
> > +#define RTE_PCI_TPH_LOC_MSIX       0x00000400 /* In MSI-X */
> > +#define RTE_PCI_TPH_CAP_ST_MASK    0x07FF0000 /* ST Table Size */
> > +#define RTE_PCI_TPH_CAP_ST_SHIFT   16      /* ST Table Size shift */
> > +#define RTE_PCI_TPH_BASE_SIZEOF    0xc     /* Size with no ST table */
> > +
> > +
>=20
> Where are all these values used? They don't seem to be needed by this pat=
ch. If
> needed in later patches, I'd suggest adding them there.
>=20

RTE_PCI_TPH_CAP_ST_NS, RTE_PCI_TPH_CAP_ST_IV and RTE_PCI_TPH_CAP_ST_DS
are used by drivers. I40e patch uses RTE_PCI_TPH_CAP_ST_DS.
I will remove the rest, added here for completeness.

> >  /** Formatting string for PCI device identifier: Ex: 0000:00:01.0 */
> > #define PCI_PRI_FMT "%.4" PRIx32 ":%.2" PRIx8 ":%.2" PRIx8 ".%" PRIx8
> > #define PCI_PRI_STR_SIZE sizeof("XXXXXXXX:XX:XX.X")
> > --
> > 2.43.0
> >
