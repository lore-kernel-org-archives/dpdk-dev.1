Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40185606A329
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.a=rsa-sha256 header.s=selector2 header.b=j7ZcbP3o
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A38740613;
	Thu,  5 Nov 2026 08:58:50 +0100 (CET)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023116.outbound.protection.outlook.com
 [40.107.44.116])
 by mails.dpdk.org (Postfix) with ESMTPS id 0943B40296
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:58:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRAICixfkc/RBG3YU3Dh4dRxAJSPhJljORFHNVNtefcJxgwBW4YY04xoTfOJlmWOcn3im0/bwo/Q5pBUKy+lFW+DV9eELSmmYqhOmsDTJ/lIkj9wF7swI5ryb6SlplfT9zjIdDlRPU4v7rZIeiOr6aQ55fx8aC5BxPDuFf3CbWEFj/YmQNI40W8CPCggZAwL9CifVPSq3HtAXAOK7s+eeZaj2OKoAC9SNISKvsybvEpHm454Y3QBN4xRqUpa/ihbpGKQ0PjurgR3Djro8l+EcC4qgd2nPN/pyki5YDzZTPWuClG7Li7xUpuM/YsU9CE0/7i7Py/4z5qQXm1yA7oz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXHHgrRZuGYCshHRIo4eGqtg2q536p6g8otSqUsdv4c=;
 b=MHfJNf+NzANvUrEB3U7DV2ZsbvdgiPYveUtH2t7rfjm4Zc1rxm7oh3sOTfIcXETEl0+wJ/nqLOBD9Hryr3xuE/r2sspjhPdhrYls5laGvYETX2uIaYX3iIF9nDX90NOTw9ZvZ7KCXYrWzK8ohkwSDGIaZ93uBBTwEHD0MCd/kJQnSnv2YPZz+4x2dP6nySmO8PJ+R232kG2EAUw+XNdnaAPfXWH8QQ1sbXKKl/T8QnRWGKsHNUduP6gwW8E0I+ruIa4OLQiiyoihM0e+0gDngL5uIzq9n8jJ0asE2e7UnDelZ8gLwvC6zJBYHOHnOyW/Edu6owc1FTAsGBOf6DTHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXHHgrRZuGYCshHRIo4eGqtg2q536p6g8otSqUsdv4c=;
 b=j7ZcbP3oSiJSCkT7W1SWz1htUasf2tZwvg/5kvEATUOythKzxxIDYGrf/YJ3EnqogPBk2BC8WFFp7I/Vyd3DcEVKk1OlmEkcJrjmL435kq+eBMCIPNQ8TZ4H4jzQ64mCVOvaHwBx0WYbDmWwSL9ZzkzMOZ0GQSdRM6CmoGOJOSMaBzw0gynErwzCBRbqxeInsZdUx8aW3qmV5na99St3XYJrsBFAUadAGY8uY02F5lXYHreVRaCifRPvF/L5KYhxx6vqsRZtfq1mLY9IASNZn4dHw3OdP42bHkWQVet2FhWN4kkWT+RPNBTca9iq3C+Vxev+0HD58ZHySsj1BjP58g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB7170.apcprd06.prod.outlook.com (2603:1096:405:b4::8)
 by OSNPR06MB8494.apcprd06.prod.outlook.com (2603:1096:604:495::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 07:58:43 +0000
Received: from TYZPR06MB7170.apcprd06.prod.outlook.com
 ([fe80::387e:d733:9980:3c98]) by TYZPR06MB7170.apcprd06.prod.outlook.com
 ([fe80::387e:d733:9980:3c98%3]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 07:58:43 +0000
From: Wei Chen <allen.chen@jaguarmicro.com>
To: dev@dpdk.org
Cc: cristian.dumitrescu@intel.com
Subject: Re: [PATCH] cfgfile: fix isspace() undefined behavior
Date: Thu,  5 Nov 2026 15:58:32 +0800
Message-Id: <20261105075832.1066-1-allen.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20261022122348.3467-1-allen.chen@jaguarmicro.com>
References: <20261022122348.3467-1-allen.chen@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To TYZPR06MB7170.apcprd06.prod.outlook.com
 (2603:1096:405:b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7170:EE_|OSNPR06MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: c81b16c0-e729-4cc3-f646-08df3b129c84
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|52116014|376014|38350700014|56012099006|55112099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: OiMWqdFlE3dG4NUMRAbYXklvktu8wYVrPevuM6eZ33jFnLctriZBG/Yvoq8qbcBxxXh3lnFXwj7cYCWtJH5hZrCMbVj7MjNtoIMuYwgPib8FQxCE8dPft2TJ7I/pBdCchR/b/YDsg7ft3DTn9WmZvR5nmZDdbrtfnvjV2R0sry2EtaNVnONGZRa5dgFyukca7kSkL6zts3nsNdh6Mgdqy384JbHaVizz5YsJjbn/E+L6yWwZDZ5anXhuGr/WTbryuXYRiZoV4g+VOEB7Lur9s93Ydny5jW2g+Rzk6xI+xNJ0hLPT4C9M9hrnB+3Zft3+DH26LDLlyUuxPXrodKH3rQZ2J9bQyw9Dbmn76kVCIGs/8h2pP4ZPUGfDsqP+VS40Zx+P07te2+V+QnevZfUTWz7wLZP3BoacYjBGu+ZEDrZRn8MEHaFNAcQZcr6U61+u9gOYL6XUTGhJUBG0P3/IPytbgqt8AP0KXOPwwANI1VLUiZvHuovt6VAJc1geZYXuoANHxWmeA0/DU5ExuNAFFxELh895okdADhtZfTNFjINKArKvlXjdt+6UEhA3KcMoaObF3prau71MhWHjklbdIBCLcgzArfdIEmcsp6Pn+Xon8ci88/7YmyA7qYjezu9hRZ49iP+m5r8XAVxtSvNFJJ1V6bu8ORC5H4oNk/F59IYjZFY2wkXY4ufWt7ahL+vkRgB4/BZsZ3TIQ4hPLkSs9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB7170.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(52116014)(376014)(38350700014)(56012099006)(55112099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UJJWMF7BzXn8xb+0TwKgb36CJGlC95GvSCSEV/Ggo6+4Jc1l7020a+ayO8Wk?=
 =?us-ascii?Q?UynIuIidjk21+6qo8QgjFFksZ4eZEce3NefPsHuQJ93mwlzMAxIPsSL7hGPG?=
 =?us-ascii?Q?frEhKy3v/BesvWyMCoZ93NbO1ujz8ABlWyLbwlmu/UAP0yZyefAsoohX+C7Y?=
 =?us-ascii?Q?dIvDElAVU+uIexRY0FGPviZ1iJUUd7UoMc1yXZItL+KVPUHE5Illf7C6DweT?=
 =?us-ascii?Q?kW9PvbJYOwJJaNjCvDAA0E9bjm7pQcoSvAm+lIa01wmlDujrmvxpEVvSWVWR?=
 =?us-ascii?Q?wBUQ4ywyuuzxNkJp8MNrB18HTrVtE2wvi/Ki9yH62Tu0i6J8xhtfv1GCy5Rw?=
 =?us-ascii?Q?yhZcZPLeGVlVqagl2YClzj0l4NEvUuXqHMTUraJwavV4nKmC86CU72N+Gu8R?=
 =?us-ascii?Q?vI2e3Jhy113KaT48Hcph4wkrel93dog/vf8a/EWQfZQm0Rdw4RIALQv2zqUt?=
 =?us-ascii?Q?VrMaWOFVZqQl9OmGEodrL4W+E52dskCskWbNt1whxEWlIByo66/PYzVaDjxy?=
 =?us-ascii?Q?7G2KxU0RlJEaJy4EAmOCzAcsOc7dax9gAeteZXNnn7sgUSebIxdHRv2hPgUp?=
 =?us-ascii?Q?1c7AjkcEb8cSwcrRdXq80HuyNOfFi1HQ9ewZ7WZlc1J9vZwnmyEwputsAr+g?=
 =?us-ascii?Q?K5Usg25tqMqhJ6Z8F4jznvIgAD46alYRMuDxrjAJXgXSdLuWB6Vw244dOgaI?=
 =?us-ascii?Q?SDWCfzeL+1JF1qJvAd7XxWB7qOfmBWwbEP0gGWk9lp5fOTKtMOdLsJ15g7dD?=
 =?us-ascii?Q?BkCZP6BUErl5n47ZR82EL4KmzWPAZzP8umzsdrHsT5YhYKQNC+c4XlRq7MCO?=
 =?us-ascii?Q?5JRC434f9Gh/j8GQLqwSaMiDWt+j39xB2D7pk+mxuTiC9QprcazzN98l9d0b?=
 =?us-ascii?Q?9GKZ9w9puDPwki12n1zrCbzp0taMTAkP8UprcJWuXUaNujVh1Rzgmi1/1xQq?=
 =?us-ascii?Q?FItAlDBG9tJw27nwywdk4fl16YcgIu3Diretf/NdocN+F83f5wiKWoBROF8s?=
 =?us-ascii?Q?ZFRBJaha5w0RmNTizXGzr4p7WRprFmStHz59/z5ryS6G0g0JDDoFlbO1YHan?=
 =?us-ascii?Q?7SKs3SL70nfhMiPkmQZo8/yZuck8AGbFYIbR+6eVLDnoAHmLL9N1niSm34Ct?=
 =?us-ascii?Q?+sfbggsnIQ5NWxZtFr/awNS09OgfGg0xkr4m/zJHGwFzTdok+G6IipLi7fc0?=
 =?us-ascii?Q?fD84pWiV5LwlJTbQuk4FObrBFTgtU2RW1S1MUbO1lVQjCU0r2G24Y/y4entI?=
 =?us-ascii?Q?XlvUW5ULOXbL4qoaqFy90ZmLCoIRfdsBgB5Bejv2gko9gRGWmGP1zKB88IPZ?=
 =?us-ascii?Q?BxJHFa2G3t1PqxTbvDJNCuD+ObFBcm1E+EqPsPYGITNc5COnWzP7shtd9Cib?=
 =?us-ascii?Q?XzlH8S/XlqS2gPkKI8cMKEXc0WllPicLMUSzeZiVyMMHF4AGNLfvAvstwdUx?=
 =?us-ascii?Q?8GIih2MKkWvGMB/AdHWVmkOs65b4ijaXrVn8bd+rHrlBFnkAzd8gTJsnO/Tn?=
 =?us-ascii?Q?bbkGAM9bH3lw9oymUpG3aDmtu9hYOw1vPP0vQzldtkan5LtpcxFlhFzUxnqz?=
 =?us-ascii?Q?NBnd6dX0FEPhzqXQR6HugHAnXxlGdhbpABu8iLrx42+37nxUkM+DQJtF1Ur4?=
 =?us-ascii?Q?hn0w+unSR3TvEwvt4xf/LqnR1ZGKFmkSuRb8wiCwNTM2quC0TerLOnV9UHo6?=
 =?us-ascii?Q?7m3kdodTCkll14QKLLEQHXd9VjLGInuywp2Z8viAKlPebix8nGQ2pydCcUX2?=
 =?us-ascii?Q?CUwOZ9GaB1PfrcHCUMqt49pNdT9d8IQ=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81b16c0-e729-4cc3-f646-08df3b129c84
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7170.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:58:43.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1I+PetWq5Uu2aTK7vaA5UXi30YkyVQr0rWnF68fb0mwZj7S1bGQs/KMhJAvRKv6FIC4Fq4NVL7XGe2NYcwEmnH16SQA/9VndcKEjwIDq/fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8494
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping. Any feedback on this patch?

Wei Chen
